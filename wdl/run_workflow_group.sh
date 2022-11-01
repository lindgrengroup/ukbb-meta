#export workflow="workflow-GJ78Y88Jg8JvV3v38z333BGZ"
workflow=$(dxCompiler compile workflow_group.wdl --folder /ukbb-meta/workflows/ -f)
dx run $workflow \
								 -istage-common.cohorts="AFR" \
						     -istage-common.cohorts="SAS" \
	               -istage-common.QCd_population_IDs="data/05_export_to_vcf/ukb_wes_450k.qced.sample_list.txt" \
                 -istage-common.QCd_population_IDs="data/05_export_to_vcf/ukb_wes_450k.qced.sample_list.txt" \
	               -istage-common.superpopulation_sample_IDs="data/superpopulation_labels.tsv" \
	               -istage-common.superpopulation_sample_IDs="data/superpopulation_labels.tsv" \
                 -istage-common.group_file="ukbb-meta/data/annotations/combined_UKB_exome_annos.txt" \
							   -istage-common.group_file="ukbb-meta/data/annotations/combined_UKB_exome_annos.txt" \
							   -istage-common.plink_binary="file-GJ4YPx0Jg8JvPZ6557jJQG6b" -istage-common.split_ancs_python_script="file-GJ4ZYQQJg8Jv9y8g1zQkzFKX" \
							   -istage-common.genotype_paths="wes_450k:/Bulk/Genotype Results/Genotype calls/" \
							   -istage-common.genotype_paths="wes_450k:/Bulk/Genotype Results/Genotype calls/" \
							   -istage-common.exome_paths="wes_450k:/data/05_export_to_plink/" \
							   -istage-common.exome_paths="wes_450k:/data/05_export_to_plink/" \
								 -istage-common.pheno_list="ukbb-meta/data/step1/BRaVa_phenotypes_with_superpopulation_labels.tsv" \
								 -istage-common.pheno="Type_two_diabetes" \
							   --destination ukbb-meta/data/workflow --priority normal -y
