for file in `cat list.txt`
do
    echo $file
    cd $file
    fslstats ACC-nucleus_accumbens/fdt_paths.nii.gz -R > ACC-nucleus_accumbens/max-intensity.txt
    VAR=`awk '{print $2}' ACC-nucleus_accumbens/max-intensity.txt`
    fslmaths ACC-nucleus_accumbens/fdt_paths.nii.gz -div $VAR ACC-nucleus_accumbens/ACC-nucleus_accumbens_fdt_paths_prob_max.nii.gz
    fslmaths ACC-nucleus_accumbens/ACC-nucleus_accumbens_fdt_paths_prob_max.nii.gz -thr 0.05 -bin ACC-nucleus_accumbens/ACC-nucleus_accumbens_fdt_paths_prob_max_mask_05.nii.gz # get the fiber path from A2B

    fslstats nucleus_accumbens-ACC/fdt_paths.nii.gz -R > nucleus_accumbens-ACC/max-intensity.txt
    VAR1=`awk '{print $2}' nucleus_accumbens-ACC/max-intensity.txt`
    fslmaths nucleus_accumbens-ACC/fdt_paths.nii.gz -div $VAR1 nucleus_accumbens-ACC/nucleus_accumbens-ACC_fdt_paths_prob_max.nii.gz
    fslmaths nucleus_accumbens-ACC/nucleus_accumbens-ACC_fdt_paths_prob_max.nii.gz -thr 0.05 -bin nucleus_accumbens-ACC/nucleus_accumbens-ACC_fdt_paths_prob_max_mask_05.nii.gz # get the fiber path from B2A

    fslmaths nucleus_accumbens-ACC/nucleus_accumbens-ACC_fdt_paths_prob_max_mask_05.nii.gz -mul ACC-nucleus_accumbens/ACC-nucleus_accumbens_fdt_paths_prob_max_mask_05.nii.gz NA2ACC_fdt_paths_prob_max_mask_05.nii.gz # get the overlap mask, for latter statistics in this mask
    cd ..
done
