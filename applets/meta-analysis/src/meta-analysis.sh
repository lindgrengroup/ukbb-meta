#!/bin/bash
# meta-analysis 0.0.1
# Generated by dx-app-wizard.
#
# Basic execution pattern: Your app will run on a single machine from
# beginning to end.
#
# Your job's input variables (if any) will be loaded as environment
# variables before this script runs.  Any array inputs will be loaded
# as bash arrays.
#
# Any code outside of main() (or any entry point you may add) is
# ALWAYS executed, followed by running the entry point itself.
#
# See https://documentation.dnanexus.com/developer for tutorials on how
# to modify this file.

main() {
    
    dx download "$vcf_file" -o vcf_file
    dx download "$group_file" -o grp_file

    # The following line(s) use the dx command-line tool to download your file
    # inputs to the local file system using variable names for the filenames. To
    # recover the original filenames, you can use the output of "dx describe
    # "$variable" --name".

    # Fill in your application code here.
    #
    # To report any recognized errors in the correct format in
    # $HOME/job_error.json and exit this script, you can use the
    # dx-jobutil-report-error utility as follows:
    #
    #   dx-jobutil-report-error "My error message"
    #
    # Note however that this entire bash script is executed with -e
    # when running in the cloud, so any line which returns a nonzero
    # exit code will prematurely exit the script; if no error was
    # reported in the job_error.json file, then the failure reason
    # will be AppInternalError with a generic error message.

    # The following line(s) use the utility dx-jobutil-add-output to format and
    # add output variables to your job's output as appropriate for the output
    # class.  Run "dx-jobutil-add-output -h" for more information on what it
    # does.
    
    mkdir -p ~/out/LD_mat

    docker pull ghcr.io/barneyhill/rare_variant_meta:release

    docker run -e cohort=$cohort -v ~/:/mnt/DNAnexus rare_variant_meta:release Rscript RV_meta.R \
                                                                                                 --num_cohorts 2 \
                                                                                                 --chr 7 \
                                                                                                 --info_file_path test_input/cohort1/LD_mat/cohort1_chr_7.marker_info.txt test_input/cohort2/LD_mat/cohort2_chr_7.marker_info.txt \
                                                                                                 --gene_file_prefix test_input/cohort1/LD_mat/cohort1_chr_7_ test_input/cohort2/LD_mat/cohort2_chr_7_ \
                                                                                                 --gwas_path test_input/cohort1/GWAS_summary/t2d_cohort1_step2_res_7.txt test_input/cohort2/GWAS_summary/t2d_cohort2_step2_res_7.txt \
                                                                                                 --output_prefix test_output/t2d_chr7_0.01_missense_lof_res.txt | tee test_log.out
    dx-upload-all-outputs
}
