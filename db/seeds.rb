# Demo data for local runs. Idempotent, so db:prepare can run it on every boot
# of a fresh database. The admin is only created when a password is supplied.
products = [
  { title: 'Stainless kettle', description: '1.7 l, auto shut-off', price: 39.90, weight: 1.2, weight_unit: 'kg' },
  { title: 'Ceramic mug', description: '350 ml, dishwasher safe', price: 6.50, weight: 320, weight_unit: 'g' },
  { title: 'Pour-over stand', description: 'Oak base with steel arm', price: 24.00 }
]
products.each { |attrs| Product.find_or_create_by!(title: attrs[:title]) { |p| p.assign_attributes(attrs) } }

if ENV['SEED_ADMIN_PASSWORD'].present?
  email = ENV.fetch('SEED_ADMIN_EMAIL', 'admin@example.com')
  Admin.find_or_create_by!(email: email) do |admin|
    admin.name = 'Demo Admin'
    admin.phone = '+1-555-0100'
    admin.password = admin.password_confirmation = ENV.fetch('SEED_ADMIN_PASSWORD')
  end
end
