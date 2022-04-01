rule compute_coverage:
    message: 'computing coverage...'
    input:
        bed = config['wdir'] + config['resources'] + 'decompiled/{sample}.bed',
        gff = config['wdir'] + config['files'] + config['genome'] + '.gff'
    benchmark:
        'benchmarks/compute_coverage_{sample}.txt'
    output:
        config['wdir'] + config['resources'] + 'differential_expression/{sample}.cov'
    shell:
        'bedtools coverage -a {input.gff} -b {input.bed} -s > {output}'


rule format_deseq_input:
    message: 'formating deseq inputs...'
    input:
        expand(config['wdir'] + config['resources'] + 'differential_expression/{sample}.cov', sample=config['samples'])
    benchmark:
        'benchmarks/format_deseq_input.txt'
    output:
        config['wdir'] + config['resources'] + 'differential_expression/DESeq_input.txt'
    shell:
        'python3 ' + config['wdir'] + config['resources'] + config['py_scripts'] + 'FormatDESeqInput.py -i {input} -o {output}'


rule run_deseq:
    message: "running DESeq..."
    input:
        deseq = config['wdir'] + config['resources'] + 'differential_expression/DESeq_input.txt',
    benchmark:
        'benchmarks/run_deseq.txt'
    output:
        temp(touch('all.done'))
    params:
        design = config['wdir'] + config['files'] + 'Design_sheet.txt'
    shell:
        'Rscript ' + config['wdir'] + config['resources'] + config['r_scripts'] + 'RunDESeq.R -i {input.deseq} -d {params.design} -o ' + config['wdir'] + config['result']