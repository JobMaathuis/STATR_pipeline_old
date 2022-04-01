configfile: 'config/config.yaml'

rule all:
    input:
        'all.done'

include: config['wdir'] + config['rules'] + 'find_degs' + config['smk']
include: config['wdir'] + config['rules'] + 'create_ribosome_profile' + config['smk']
include: config['wdir'] + config['rules'] + 'decompile_alignment' + config['smk']
include: config['wdir'] + config['rules'] + 'trim_reads' + config['smk']
include: config['wdir'] + config['rules'] + 'align_reads' + config['smk']


