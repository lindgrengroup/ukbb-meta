version 1.1

task SPAtests {
    input {
	String test_type
	File group_file
	Int chrom
	File exome_bed
	File exome_bim
	File exome_fam
	File model_file
	File variance_ratios
	File GRM
	File GRM_samples
	File sample_file
    }

    command <<<
    set -ex

    cat ~{sample_file} | awk -F " " '{ print $1 }' > sample_file_trim	
    
    if [ "~{test_type}" = "gene" ]; then
    	#sed 's/ ~{chrom}:/ chr~{chrom}:/g' ~{group_file} > group_file_processed

    	step2_SPAtests.R --bedFile ~{exome_bed} \
			     --bimFile ~{exome_bim} \
			     --famFile ~{exome_fam} \
			     --GMMATmodelFile ~{model_file} \
			     --varianceRatioFile ~{variance_ratios} \
			     --sparseGRMFile ~{GRM} \
			     --sparseGRMSampleIDFile ~{GRM_samples} \
			     --SAIGEOutputFile associations.txt \
			     --LOCO FALSE \
			     --is_Firth_beta TRUE \
			     --pCutoffforFirth=0.05 \
			     --is_fastTest=TRUE \
			     --subSampleFile sample_file_trim \
			     --chrom "chr~{chrom}"

    elif [ "~{test_type}" = "variant" ]; then
    	step2_SPAtests.R --bedFile ~{exome_bed} \
			     --bimFile ~{exome_bim} \
			     --famFile ~{exome_fam} \
			     --GMMATmodelFile ~{model_file} \
			     --varianceRatioFile ~{variance_ratios} \
			     --sparseGRMFile ~{GRM} \
			     --sparseGRMSampleIDFile ~{GRM_samples} \
			     --SAIGEOutputFile associations.txt \
			     --LOCO FALSE \
			     --is_Firth_beta TRUE \
			     --pCutoffforFirth=0.05 \
			     --is_fastTest=TRUE \
			     --subSampleFile sample_file_trim \
			     --chrom "chr~{chrom}" \
			     --groupFile=group_file_processed \
			     --annotation_in_groupTest damaging_missense,pLoF,synonymous,pLoF:damaging_missense,damaging_missense:pLoF:synonymous

    fi

    >>>

	runtime{
		docker: "dx://wes_450k:/ukbb-meta/docker/saige-1.1.6.1.tar.gz"
		dx_instance_type: "mem2_ssd1_v2_x4"
		dx_access: object {
		    network: ["*"],
		    project: "VIEW"
		}
	}

    output {
        File associations = "associations.txt"
    }
}

