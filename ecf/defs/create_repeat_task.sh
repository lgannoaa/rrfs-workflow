#!/bin/bash
set -x

# configuration
member_num_begging=1
member_num_max=1
member_num_inc=1
member_num=${member_num_begging}

hour_num_begging=0
hour_num_max=0
hour_num_inc=1
hour_num=${hour_num_begging}

lbcs_num_begging=1
lbcs_num_max=30
lbcs_num_inc=1
lbcs_num=${lbcs_num_begging}

DATA=/lfs/h2/emc/ptmp/lin.gan/ecflow_aqm/para/output/prod/today/test1
mkdir -p ${DATA};chmod 700 ${DATA};cd ${DATA}
COMOUT=${DATA}/seed_6.txt
rm -f ${COMOUT}

# process loop
while [ ${lbcs_num} -le ${lbcs_num_max} ]; do
  lbcs_num3d=$( printf "%03d" "${lbcs_num}" )

  pre_sp_task_pt1='              '
  task_pt1="task jrrfs_ens_prep_cyc_spinup_ensinit_mem${lbcs_num3d}"
  pre_sp_trigger_pt1='                '
  trigger_pt1="trigger ../../ics/ens/jrrfs_ens_blend_ics_mem${lbcs_num3d}==complete and ../../forecast/ens/jrrfs_ens_save_restart_ensinit_mem${lbcs_num3d}==complete and ../../fsm:release_ens_prep_cyc_spinup_ensinit_mem${lbcs_num3d}"

#  task_pt2="task jrrfs_det_prdgen_f${lbcs_num3d}-15-00"
#  trigger_pt2="trigger ../../fsm:release_det_prdgen_f${lbcs_num3d}-15-36"  
#  task_pt3="task jrrfs_det_prdgen_f${lbcs_num3d}-30-00"
#  trigger_pt3="trigger ../../fsm:release_det_prdgen_f${lbcs_num3d}-30-36"
#  task_pt4="task jrrfs_det_prdgen_f${lbcs_num3d}-45-00"
#  trigger_pt4="trigger ../../fsm:release_det_prdgen_f${lbcs_num3d}-45-36"


  printf '%s\n' "${pre_sp_task_pt1}${task_pt1}" >> ${COMOUT}
  printf '%s\n' "${pre_sp_trigger_pt1}${trigger_pt1}" >> ${COMOUT}
#  printf '%s\n' "${pre_sp_task_pt1}${task_pt2}" >> ${COMOUT}
#  printf '%s\n' "${pre_sp_trigger_pt1}${trigger_pt2}" >> ${COMOUT}
#  printf '%s\n' "${pre_sp_task_pt1}${task_pt3}" >> ${COMOUT}
#  printf '%s\n' "${pre_sp_trigger_pt1}${trigger_pt3}" >> ${COMOUT}
#  printf '%s\n' "${pre_sp_task_pt1}${task_pt4}" >> ${COMOUT}
#  printf '%s\n' "${pre_sp_trigger_pt1}${trigger_pt4}" >> ${COMOUT}

  lbcs_num=$((lbcs_num+lbcs_num_inc))
done

exit 0

while [ ${member_num} -le ${member_num_max} ]; do 
  while [ ${hour_num} -le ${hour_num_max} ]; do
    member_num3d=$( printf "%03d" "${member_num}" )
    hour_num3d=$( printf "%03d" "${hour_num}" )
    pre_sp_task_pt1='              '
    task_pt1="task jrrfs_ensf_prdgen_mem${member_num3d}_f${hour_num3d}"
    pre_sp_trigger_pt1='                '
    trigger_pt1="trigger ../../post/jrrfs_ensf_post_mem${member_num3d}_f${hour_num3d}==complete"
    printf '%s\n' "${pre_sp_task_pt1}${task_pt1}" >> seed_1.txt
    printf '%s\n' "${pre_sp_trigger_pt1}${trigger_pt1}" >> seed_1.txt
    hour_num=$((hour_num+hour_num_inc))
  done
  member_num=$((member_num+member_num_inc))
  hour_num=${hour_num_begging}
done

exit
