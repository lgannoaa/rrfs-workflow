#!/bin/bash
set -x

# configuration
event_num_begging=280
#event_num_max=1
event_num_inc=1
event_num=${event_num_begging}

hour_num_begging=1
hour_num_max=1
hour_num_inc=1
hour_num=${hour_num_begging}

group_num_begging=1
group_num_max=1
group_num_inc=1
group_num=${group_num_begging}

member_num_begging=1
member_num_max=30
member_num_inc=1
member_num=${member_num_begging}

DATA=/lfs/h2/emc/ptmp/lin.gan/ecflow_aqm/para/output/prod/today/test1
mkdir -p ${DATA};chmod 700 ${DATA};cd ${DATA}
COMOUT=${DATA}/seed_7.txt
rm -f ${COMOUT}

# process loop
while [ ${member_num} -le ${member_num_max} ]; do
 member_num3d=$( printf "%03d" "${member_num}" )
 while [ ${group_num} -le ${group_num_max} ]; do
  group_num2d=$( printf "%02d" "${group_num}" )
  while [ ${hour_num} -le ${hour_num_max} ]; do
    hour_num3d=$( printf "%03d" "${hour_num}" )
    sp_1='            '

    # task_1="event ${event_num} release_ens_make_lbcs_${group_num2d}_mem${member_num3d}"
    # task_1="event ${event_num} release_ensf_post_mem${member_num3d}_f${hour_num3d}"
    task_1="event ${event_num} release_ens_prep_cyc_spinup_ensinit_mem${member_num3d}"
    event_num=$((event_num+event_num_inc))
#    task_2="event ${event_num} release_det_prdgen_f${hour_num3d}_15_00"
#    event_num=$((event_num+event_num_inc))
#    task_3="event ${event_num} release_det_prdgen_f${hour_num3d}_30_00"
#    event_num=$((event_num+event_num_inc))
#    task_4="event ${event_num} release_det_prdgen_f${hour_num3d}_45_00"
#    event_num=$((event_num+event_num_inc))

    printf '%s\n' "${sp_1}${task_1}" >> ${COMOUT}
#    printf '%s\n' "${sp_1}${task_2}" >> ${COMOUT}
#    printf '%s\n' "${sp_1}${task_3}" >> ${COMOUT}
#    printf '%s\n' "${sp_1}${task_4}" >> ${COMOUT}


    hour_num=$((hour_num+hour_num_inc))
#    event_num=$((event_num+event_num_inc))
  done
  hour_num=${hour_num_begging}
  group_num=$((group_num+group_num_inc))
 done
  group_num=${group_num_begging}
  member_num=$((member_num+member_num_inc))
done

exit 0
#########################################################################################################
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
