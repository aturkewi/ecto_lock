defmodule EctoLock.Helper do

  alias EctoLock.BillPendingInvoices

  def create_invoices do
    BillPendingInvoices.create_pending_invoice()
    BillPendingInvoices.create_pending_invoice()
    BillPendingInvoices.create_pending_invoice()
  end
end
