XRR_Acc_file=$1 #XRR for SRR or ERR

fasp_base_url=anonftp@ftp.ncbi.nlm.nih.gov:/sra/sra-instant/reads/ByRun/sra/
aspera_base=/home/hangc/.aspera/connect

while read line
do
    srr_prefix=${line:0:6}
    xrr=${line:0:3}
    fasp_url=${fasp_base_url}/${xrr}/${srr_prefix}/${line}/${line}.sra
    if [ -f ${line}.sra -a ! -f ${line}.sra.aspx ];then
	echo "${line}.sra already exists, skip..."
    else
	echo "downloading $line"
	${aspera_base}/bin/ascp -i ${aspera_base}/etc/asperaweb_id_dsa.openssh -k3 -T -l20m ${fasp_url} . ##-T will disable encryption...
    fi
done < ${XRR_Acc_file}
