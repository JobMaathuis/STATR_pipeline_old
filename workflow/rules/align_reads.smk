rule index_genome:
    message: 'indexing...'
    input:
        genome = config['wdir'] + config['files'] + config['genome'] + '.fa'
    output:
        temp(touch('index.done'))
    benchmark:
        'benchmarks/index_genome.txt'
    params:
        index = config['wdir'] + config['resources'] + 'aligned/' + config['genome']
    shell:
        'bowtie2-build -f {input.genome} {params.index}'


rule align_reads:
    message: 'aliging reads...'
    input: 
        check = 'index.done',
        trimmed = config['wdir'] + config['resources'] + 'trimmed/{sample}_trimmed' + config['fastq']
    output:
        config['wdir'] + config['resources'] + 'aligned/{sample}.sam'
    benchmark:
        'benchmarks/align_reads_{sample}.txt'
    threads: 4
    params:
        index = config['wdir'] + config['resources'] + 'aligned/' + config['genome']
    shell:
        'bowtie2 -q -U {input.trimmed} -x {params.index} -S {output} --local --threads {threads}'