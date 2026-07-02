#!/usr/bin/env bash
# Downloads all anatomical reference plates from Wikimedia with a compliant
# User-Agent (this is what fixes the 403). Run on a machine/CI that can reach
# commons.wikimedia.org. Output: ./plates/*.png|jpg  Then host ./plates on a
# fetcher-friendly location (GitHub raw, S3, Cloudinary) and set BASE_URL in
# fill_attach_urls.py.
set -euo pipefail
UA="MediViz-ReferenceLibrary/1.0 (https://example.com; tomkorpez@gmail.com)"
mkdir -p plates
while IFS=$'\t' read -r url out; do
  echo "-> $out"
  curl -L --fail --retry 3 --retry-delay 2 -A "$UA" "$url" -o "plates/$out"
  sleep 1  # be polite; avoid rate limiting
done <<'EOF'
https://commons.wikimedia.org/wiki/Special:FilePath/Human_skeleton_front_no-text_no-color.svg?width=1400	skeleton_full_anterior.png
https://commons.wikimedia.org/wiki/Special:FilePath/Human_skeleton_back_no-text_no-color.svg?width=1400	skeleton_full_posterior.png
https://commons.wikimedia.org/wiki/Special:FilePath/Human_skeleton_front_-_no_labels.svg?width=1400	skeleton_full_anterior_colored_alt.png
https://commons.wikimedia.org/wiki/Special:FilePath/Rib_cage_anterior.svg?width=1400	ribcage_anterior.png
https://commons.wikimedia.org/wiki/Special:FilePath/Illu_vertebral_column.svg?width=1400	vertebral_column_lateral.png
https://commons.wikimedia.org/wiki/Special:FilePath/Human_skull_front_simplified_(bones).svg?width=1400	skull_anterior.png
https://commons.wikimedia.org/wiki/Special:FilePath/Human_skull_side_simplified_(bones).svg?width=1400	skull_lateral.png
https://commons.wikimedia.org/wiki/Special:FilePath/Human_arm_bones_diagram.svg?width=1400	upper_limb_bones.png
https://commons.wikimedia.org/wiki/Special:FilePath/Human_leg_bones_labeled.svg?width=1400	lower_limb_bones.png
https://commons.wikimedia.org/wiki/Special:FilePath/Scheme_human_hand_bones-en.svg?width=1400	hand_bones.png
https://commons.wikimedia.org/wiki/Special:FilePath/202111_Lateral_view_of_bones_of_right_foot.svg?width=1400	foot_bones.png
https://commons.wikimedia.org/wiki/Special:FilePath/Bougle,_Human_muscular_system,_anterior-ca.svg?width=1400	muscles_superficial_anterior.png
https://commons.wikimedia.org/wiki/Special:FilePath/Bougle,_Human_muscular_system,_posterior-ca.svg?width=1400	muscles_superficial_posterior.png
https://commons.wikimedia.org/wiki/Special:FilePath/Rectus_abdominis.png?width=1400	abdominal_wall_rectus_abdominis.png
https://commons.wikimedia.org/wiki/Special:FilePath/Surface_projections_of_the_organs_of_the_trunk_-_without_labels.svg?width=1400	organ_situs_trunk_anterior.png
https://commons.wikimedia.org/wiki/Special:FilePath/Internal_organs.svg?width=1400	internal_organs_full_situs.png
https://commons.wikimedia.org/wiki/Special:FilePath/Diagram_of_the_human_heart_(no_labels).svg?width=1400	heart.png
https://commons.wikimedia.org/wiki/Special:FilePath/Lungs_diagram_simple.svg?width=1400	lungs.png
https://commons.wikimedia.org/wiki/Special:FilePath/Respiratory_system_complete_en.svg?width=1400	respiratory_tree.png
https://commons.wikimedia.org/wiki/Special:FilePath/Liver_Diagram.svg?width=1400	liver.png
https://commons.wikimedia.org/wiki/Special:FilePath/Stomach_diagram.svg?width=1400	stomach.png
https://commons.wikimedia.org/wiki/Special:FilePath/Digestive_system_without_labels.svg?width=1400	digestive_system.png
https://commons.wikimedia.org/wiki/Special:FilePath/Urinary_System_Large_Unlabeled.jpg?width=1400	urinary_system.jpg
https://commons.wikimedia.org/wiki/Special:FilePath/Circulatory_System_no_tags.svg?width=1400	circulatory_system_full.png
https://commons.wikimedia.org/wiki/Special:FilePath/Arterial_System_en.svg?width=1400	arterial_system_full.png
https://commons.wikimedia.org/wiki/Special:FilePath/Venous_system_en.svg?width=1400	venous_system_full.png
https://commons.wikimedia.org/wiki/Special:FilePath/Coronary_arteries.svg?width=1400	coronary_arteries.png
https://commons.wikimedia.org/wiki/Special:FilePath/Circle_of_Willis_unlabeled.svg?width=1400	circle_of_willis.png
https://commons.wikimedia.org/wiki/Special:FilePath/Nervous_system_diagram_unlabeled.svg?width=1400	nervous_system_full.png
https://commons.wikimedia.org/wiki/Special:FilePath/Brain_diagram_without_text.svg?width=1400	brain_lateral.png
https://commons.wikimedia.org/wiki/Special:FilePath/Skeleton_whole_body_ant_lat_views.svg?width=1400	skeleton_full_lateral.png
https://commons.wikimedia.org/wiki/Special:FilePath/730_Posterior_View_Skull.jpg?width=1400	skull_posterior.jpg
https://commons.wikimedia.org/wiki/Special:FilePath/1106_Front_and_Side_Views_of_the_Muscles_of_Facial_Expressions.jpg?width=1400	head_face_muscles.jpg
EOF
echo "Done. $(ls plates | wc -l) files in ./plates"
