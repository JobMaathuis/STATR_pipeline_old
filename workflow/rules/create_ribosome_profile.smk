rule parse_genome_annotation:
    message: 'parsing genome annotation...'
    input:
        config['wdir'] + config['files'] + config['genome'] + '.gff3'
    output:
        config['wdir'] + config['files'] + config['genome'] + '.gff'
    # benchmark:
        'benchmarks/parse_genome_annotation_{output}.txt'
    shell:
        'python3 ' + config['wdir'] + config['resources'] + config['py_scripts'] + 'ParseGenomeAnnotation.py -i {input} -o {output}'


rule check_periodicity:
    message: 'checking periodicity...'
    input:
        bed = config['wdir'] + config['resources'] + 'decompiled/{sample}.bed',
        gff = config['wdir'] + config['files'] + config['genome'] + '.gff'
    benchmark:
        'benchmarks/check_periodicity_{sample}.txt'
    output:
        config['wdir'] + config['resources'] + 'meta_analysis/{sample}.txt'
    shell:
        'python3 ' + config['wdir'] + config['resources'] + config['py_scripts'] + 'CheckPeriodicity.py -i {input.bed} -a {input.gff} -o {output}'


rule generate_profile:
    message: 'generating profile..'
    input:
        bed = config['wdir'] + config['resources'] + 'decompiled/{sample}.bed',
        gff = config['wdir'] + config['files'] + config['genome'] + '.gff'
    benchmark:
        'benchmarks/generate_profile_{sample}.txt'
    output:
        config['wdir'] + config['resources'] + 'meta_analysis/{sample}_profile.gff'
    shell:
        'python3 ' + config['wdir'] + config['resources'] + config['py_scripts'] + 'GenerateProfile.py -i {input.bed} -e 5 -a {input.gff} -n 1000000 -o {output}'
