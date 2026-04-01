# you can analyze the FA/AD/MD/RD values in the fiber path mask; or analyze the fiber connectivity strength
# this is the backup script, if you want to calculate the fiber connectivity strength.
for file in `cat list.txt`
do
    echo $file
    fslstats /mnt/data/guangzhounaokeyuan_data/Structural_connection_guangzhounaokeyuan-Kangning/DTI/$file/ROIdti_SMA_AAL90.nii.gz -V >> SMA_voxel_number.txt
    fslstats /mnt/data/guangzhounaokeyuan_data/Structural_connection_guangzhounaokeyuan-Kangning/DTI/$file/ROIdti_putamen.nii.gz -V >> putamen_voxel_number.txt
    awk '{print $1}' $file/SMA-putamen/waytotal >> SMA-putamen_waytotal.txt
    awk '{print $1}' $file/putamen-SMA/waytotal >> putamen-SMA_waytotal.txt
done
