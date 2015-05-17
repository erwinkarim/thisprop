# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

DwellingKind.create( [
	{ name:'Banglo', description:'Fully Detached House' },
	{ name:'Semi-D', description:'Semi-Detached House' },
	{ name:'Cluster', description:'Cluster Home. Usually 4 homes shares a common wall' },
	{ name:'Link', description:'Link-House. Usually Linked side-by-side' },
	{ name:'Condominum', description:'High-End Condominums' },
	{ name:'Apartment', description:'Medium Cost Flats' },
	{ name:'Flat', description:'Flats' }])

District.create( [
	{ name:'Taman Melawati' },
	{ name:'Bukit Antarabangsa' },
	{ name:'Pandan Jaya' },
	{ name:'Ampang Jaya' },
	{ name:'Ampang Mewah' },
	{ name:'Taman Bukit Ampang' },
	{ name:'Taman Halaman' },
	{ name:'Taman Dagang Jaya' },
	{ name:'Taman Seri Intan' },
	{ name:'Taman Saujana Ampang' },
	{ name:'Taman Mulia Jaya' },
	{ name:'Ukay Heights' },
	{ name:'Taman Tun Abdul Razak' },
	{ name:'Taman Desa Keramat' },
	{ name:'Taman Sri Ukay' },
	{ name:'Desa Pandan' },
	{ name:'Beverly Heights' },
	{ name:'Setia Hills' },
	{ name:'Kampung Tengah Ampang' },
	{ name:'Tropicana Villa' },
	{ name:'Others' }
]);
