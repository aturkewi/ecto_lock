defmodule EctoLock.TestLocking do
  alias EctoLock.{Invoice, Repo}

  def insert_invoice do
    %Invoice{}
    |> Invoice.changeset(%{pending: true})
    |> Repo.insert()
  end

  def lock_slow(invoice_id) do
    invoice = Invoice
    |> Invoice.get_and_lock_invoice(invoice_id)
    |> Repo.one()

    :timer.sleep(3000)

    invoice
    |> Invoice.changeset(%{pending: true})
    |> Repo.update()
    |> IO.inspect()
    IO.puts("Invoice updated slow")
  end

  def lock_fast(invoice_id) do
    invoice = Invoice
    |> Invoice.get_and_lock_invoice(invoice_id)
    |> Repo.one()

    :timer.sleep(1000)

    invoice
    |> Invoice.changeset(%{pending: false})
    |> Repo.update()
    |> IO.inspect()
    IO.puts("Invoice updated fast")
  end

  def test do
    {:ok, invoice} = insert_invoice()

    spawn fn ->
      lock_slow(invoice.id)
    end
    :timer.sleep(500)
    spawn fn ->
      lock_fast(invoice.id)
    end
  end
end
