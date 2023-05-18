fx_version 'cerulean'
game 'gta5'

author 'Sly Zapesti#9737'
description 'sBraquage'


client_scripts {
    'client/sBraquageGaragec.lua',
    'client/venteBraquagevehiculec.lua',
	'client/blipBraquageGarage.lua'
}

server_script {
    'server/sBraquageGaragev.lua'
}

files {
	'MotoB/carcols.meta',
	'MotoB/carvariations.meta',
	'MotoB/dlctext.meta',
	'MotoB/handling.meta',
	'MotoB/vehicles.meta',
	'MotoB/*.meta'
}
data_file 'DLCTEXT_FILE' 'MotoB/dlctext.meta'
data_file 'HANDLING_FILE' 'MotoB/handling.meta'
data_file 'VEHICLE_METADATA_FILE' 'MotoB/vehicles.meta'
data_file 'CARCOLS_FILE' 'MotoB/carcols.meta'
data_file 'VEHICLE_VARIATION_FILE' 'MotoB/carvariations.meta'
