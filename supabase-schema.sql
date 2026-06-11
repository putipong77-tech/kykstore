-- ===== ร้านเทพ Store — Supabase Schema =====
-- รันใน Supabase Dashboard > SQL Editor

create table products (
  id          bigserial primary key,
  name        text not null,
  category    text not null default 'อื่นๆ',
  price       numeric(10,2) not null default 0,
  cost        numeric(10,2) not null default 0,
  stock       integer not null default 0,
  created_at  timestamptz default now()
);

create table sales (
  id          bigserial primary key,
  total       numeric(10,2) not null,
  profit      numeric(10,2) not null,
  created_at  timestamptz default now()
);

create table sale_items (
  id          bigserial primary key,
  sale_id     bigint references sales(id) on delete cascade,
  product_id  bigint references products(id),
  product_name text not null,
  qty         integer not null,
  price       numeric(10,2) not null,
  cost        numeric(10,2) not null
);

-- ข้อมูลตัวอย่าง
insert into products (name, category, price, cost, stock) values
  ('น้ำดื่ม 600ml', 'เครื่องดื่ม', 10, 5, 48),
  ('ข้าวกล่อง',     'อาหาร',      45, 25, 12),
  ('มาม่า',         'อาหาร',       6,  3, 80),
  ('ขนมปัง',        'ขนม',         25, 15,  8),
  ('กาแฟเย็น',      'เครื่องดื่ม', 35, 18,  0),
  ('สบู่ก้อน',      'ของใช้',      30, 18,  5);

-- Enable Row Level Security (ปิดก่อนเพื่อความง่าย ค่อยเปิดทีหลัง)
alter table products enable row level security;
alter table sales    enable row level security;
alter table sale_items enable row level security;

-- Policy: อนุญาตทุก operation (ปรับแก้ถ้าต้องการ auth)
create policy "allow all" on products for all using (true) with check (true);
create policy "allow all" on sales    for all using (true) with check (true);
create policy "allow all" on sale_items for all using (true) with check (true);
