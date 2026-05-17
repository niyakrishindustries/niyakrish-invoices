-- Enable UUID extension
create extension if not exists "uuid-ossp";

-- Customers table
create table if not exists customers (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  phone text,
  gstin text,
  address text,
  site_address text,
  pincode text,
  email text,
  created_at timestamptz default now(),
  updated_at timestamptz default now()
);

-- Invoices table
create table if not exists invoices (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references auth.users(id) on delete cascade,
  customer_id uuid references customers(id) on delete set null,
  invoice_no text not null,
  invoice_date timestamptz not null,
  po_number text,
  status text default 'draft' check (status in ('draft', 'sent', 'paid', 'cancelled', 'overdue')),
  sub_total numeric(12, 2),
  cgst_total numeric(12, 2),
  sgst_total numeric(12, 2),
  tcs_amount numeric(12, 2),
  net_amount numeric(12, 2),
  amount_words text,
  created_at timestamptz default now(),
  updated_at timestamptz default now(),
  unique(user_id, invoice_no)
);

-- Invoice items table
create table if not exists invoice_items (
  id uuid primary key default uuid_generate_v4(),
  invoice_id uuid not null references invoices(id) on delete cascade,
  grade text,
  quantity numeric(10, 2),
  rate numeric(10, 2),
  gross_amount numeric(12, 2),
  cgst_percentage numeric(5, 2),
  sgst_percentage numeric(5, 2),
  created_at timestamptz default now()
);

-- Products/Services table
create table if not exists products (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references auth.users(id) on delete cascade,
  hsn_code text,
  hsn_description text,
  product_name text,
  created_at timestamptz default now()
);

-- Payments table
create table if not exists payments (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references auth.users(id) on delete cascade,
  invoice_id uuid references invoices(id) on delete cascade,
  payment_date timestamptz not null,
  amount numeric(12, 2),
  method text,
  reference_no text,
  created_at timestamptz default now()
);

-- Templates table
create table if not exists templates (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null,
  terms_conditions text,
  bank_details jsonb,
  logo_url text,
  created_at timestamptz default now()
);

-- Enable Row Level Security
alter table customers enable row level security;
alter table invoices enable row level security;
alter table invoice_items enable row level security;
alter table payments enable row level security;
alter table templates enable row level security;
alter table products enable row level security;

-- RLS Policies for customers
create policy "Users can view their own customers" on customers
  for select using (auth.uid() = user_id);

create policy "Users can create customers" on customers
  for insert with check (auth.uid() = user_id);

create policy "Users can update their own customers" on customers
  for update using (auth.uid() = user_id);

create policy "Users can delete their own customers" on customers
  for delete using (auth.uid() = user_id);

-- RLS Policies for invoices
create policy "Users can view their own invoices" on invoices
  for select using (auth.uid() = user_id);

create policy "Users can create invoices" on invoices
  for insert with check (auth.uid() = user_id);

create policy "Users can update their own invoices" on invoices
  for update using (auth.uid() = user_id);

create policy "Users can delete their own invoices" on invoices
  for delete using (auth.uid() = user_id);

-- RLS Policies for invoice_items
create policy "Users can view items from their invoices" on invoice_items
  for select using (
    exists (
      select 1 from invoices where invoices.id = invoice_items.invoice_id and invoices.user_id = auth.uid()
    )
  );

create policy "Users can create items for their invoices" on invoice_items
  for insert with check (
    exists (
      select 1 from invoices where invoices.id = invoice_items.invoice_id and invoices.user_id = auth.uid()
    )
  );

-- RLS Policies for payments
create policy "Users can view their own payments" on payments
  for select using (auth.uid() = user_id);

create policy "Users can create payments" on payments
  for insert with check (auth.uid() = user_id);

-- RLS Policies for templates
create policy "Users can view their own templates" on templates
  for select using (auth.uid() = user_id);

create policy "Users can create templates" on templates
  for insert with check (auth.uid() = user_id);

-- RLS Policies for products
create policy "Users can view their own products" on products
  for select using (auth.uid() = user_id);

create policy "Users can create products" on products
  for insert with check (auth.uid() = user_id);

-- Create indexes for better query performance
create index if not exists idx_customers_user_id on customers(user_id);
create index if not exists idx_invoices_user_id on invoices(user_id);
create index if not exists idx_invoices_customer_id on invoices(customer_id);
create index if not exists idx_invoices_status on invoices(status);
create index if not exists idx_invoice_items_invoice_id on invoice_items(invoice_id);
create index if not exists idx_payments_invoice_id on payments(invoice_id);
create index if not exists idx_payments_user_id on payments(user_id);
create index if not exists idx_templates_user_id on templates(user_id);
create index if not exists idx_products_user_id on products(user_id);
