rule trim_reads:
    message: 'trimming reads...'
    input:
        config['wdir'] + config['files'] + '{sample}' + config['fastq']
    benchmark:
        'benchmarks/trim_reads_{sample}.txt'
    output:
        config['wdir'] + config['resources'] + 'trimmed/{sample}_trimmed' + config['fastq']
    threads: 2
    shell:
        'java -jar ' + config['wdir'] + config['resources'] + config['trimmomatic'] + ' SE -threads {threads} -phred33 {input} {output} '
        'ILLUMINACLIP:' + config['wdir'] + config['files'] + config['adapter'] + ':2:30:6 SLIDINGWINDOW:4:15 MINLEN:12'