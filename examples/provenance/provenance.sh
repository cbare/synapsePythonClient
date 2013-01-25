## example using command-line client to create a data entity
## with provenance

## Note that this assumes you have a .synapseConfig file in
## your home directory so the client can log in automatically

## first, let's dump some data into a file
python generate_random_data.py > data.txt

## Create a project in synapse
synapse create -name "provenance test project" Project
#>> Created entity: syn1656771  provenance test project

## Add a couple of entities to our project, first a Data entity...
synapse add -parentid syn1656771 -name "data.txt" -description "My randomly generated data" data.txt
#>> Created entity: syn1656772  data.txt from file: data.txt

## ...and a Code entity that holds the script
synapse add -parentid syn1656771 -name "generate_random_data.py" -description "Generate data randomly from the normal distribution" -type "Code" generate_random_data.py
#>> Created entity: syn1656774  generate_random_data.py from file: generate_random_data.py

## Add provenance to the effect that the data entity was generated by executing the code entity
synapse provenance -id syn1656772 -name 'generate random data' -description 'A fabulous script generated this random data' -executed syn1656774
#>> {"used": [{"reference": {"targetId": "syn1656774"}, "wasExecuted": true}], "modifiedOn": "2013-01-24T23:44:25.028Z", "description": "zippety dippety doo", "createdOn": "2013-01-24T23:44:25.028Z", "etag": "dab0a504-d60d-492b-913d-b09592a1c68a", "modifiedBy": "377358", "createdBy": "377358", "id": "1657086", "name": "generate random data"}

## retrieve the activity like this:
synapse provenance -id syn1656772
#>> {"used": [{"reference": {"targetId": "syn1656774"}, "wasExecuted": true}], "modifiedOn": "2013-01-24T23:44:25.028Z", "description": "zippety dippety doo", "createdOn": "2013-01-24T23:44:25.028Z", "etag": "dab0a504-d60d-492b-913d-b09592a1c68a", "modifiedBy": "377358", "createdBy": "377358", "id": "1657086", "name": "generate random data"}
