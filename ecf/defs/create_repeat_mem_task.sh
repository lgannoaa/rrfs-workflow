#!/bin/bash
set -x

# configuration
member_num_begging=1
member_num_max=5
member_num_inc=1
member_num=${member_num_begging}

hour_num_begging=0
hour_num_max=60
hour_num_inc=1
hour_num=${hour_num_begging}

DATA=/lfs/h2/emc/ptmp/lin.gan/ecflow_aqm/para/output/prod/today/test1
mkdir -p ${DATA};chmod 700 ${DATA};cd ${DATA};rm -f ${DATA}/seed.txt

# process loop
while [ ${member_num} -le ${member_num_max} ]; do 
  while [ ${hour_num} -le ${hour_num_max} ]; do
    member_num3d=$( printf "%03d" "${member_num}" )
    hour_num3d=$( printf "%03d" "${hour_num}" )
    pre_sp_task_pt1='              '
    task_pt1="task jrrfs_ensf_prdgen_mem${member_num3d}_f${hour_num3d}"
    pre_sp_trigger_pt1='                '
    trigger_pt1="trigger ../../post/jrrfs_ensf_post_mem${member_num3d}_f${hour_num3d}==complete"
    printf '%s\n' "${pre_sp_task_pt1}${task_pt1}" >> seed.txt
    printf '%s\n' "${pre_sp_trigger_pt1}${trigger_pt1}" >> seed.txt
    hour_num=$((hour_num+hour_num_inc))
  done
  member_num=$((member_num+member_num_inc))
  hour_num=${hour_num_begging}
done

exit
