rule convert_sam_to_bam:
    message: 'converting .sam to .bam...'
    input:
        config['wdir'] + config['resources'] + 'aligned/{sample}.sam'
    benchmark:
        'benchmarks/convert_sam_to_bam_{sample}.txt'
    output:
        config['wdir'] + config['resources'] + 'decompiled/{sample}.bam'
    shell:
        'samtools view -bS {input} > {output}'


rule sort_bam:
    message: 'sorting .bam file...'
    input:
        config['wdir'] + config['resources'] + 'decompiled/{sample}.bam'
    benchmark:
        'benchmarks/sort_bam_{sample}.txt'
    output:
        config['wdir'] + config['resources'] + 'decompiled/{sample}_sorted.bam'
    shell:
        'samtools sort {input} -o {output}'


rule convert_bam_to_bed:
    message: 'converting .bam to .bed...'
    input:
        config['wdir'] + config['resources'] + 'decompiled/{sample}_sorted.bam'
    benchmark:
        'benchmarks/convert_bam_to_bed_{sample}.txt'
    output:
        config['wdir'] + config['resources'] + 'decompiled/{sample}.bed'
    shell:
        'bedtools bamtobed -i {input} > {output}'