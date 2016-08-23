# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Invoice.destroy_all

bob = Client.create!(
  first_name: "Boris",
  last_name: "Paillard",
  company: "Le Wagon",
  company_number: 17555,
  address: "16 villa Gaudelet",
  email: "boris@lewagon.org"
)

invoice = Invoice.create!(
  freelancer_id: 1,
  client_id: bob.id,
  invoice_date: Date.today,
  due_date: Date.today,
  invoice_nr: 86764,
  invoice_terms: "Pay fast"
)
invoice_bis = Invoice.create!(
  freelancer_id: 1,
  client_id: bob.id,
  invoice_date: Date.today,
  due_date: Date.today,
  invoice_nr: 86764,
  invoice_terms: "Pay really fast"
)

desc = Description.create(
  invoice_id: invoice.id,
  description: "Ad word mission",
  unit: 3,
  price: 500,
  amount: 1500,
  vat_tax: 20
)
desc_bis = Description.create(
  invoice_id: invoice_bis.id,
  description: "Frontend rework",
  unit: 1,
  price: 500,
  amount: 500,
  vat_tax: 20
)

