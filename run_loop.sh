bkgd_optim () {
	export CUDA_VISIBLE_DEVICES=$1
	python projector.py\
		--ckpt /home/ubuntu/modidatasets/Flickr-Faces-HQ-Dataset/checkpoints/stylegan2_1024px_large/stylegan2-ffhq-config-f.pt\
		--size 1024\
		$2
}

# create array of ids that are to be used
filename="/home/ubuntu/vid2vid-research/meta_files/ffhq_hair_ids.txt"
array=()
while read -r line; do
	name="$line"
	array+=($name)
done < "$filename"
array_len=${#array[@]}

for (( i=0 ; i<120; i=i+4))
	do

		FILE1='/home/ubuntu/raw/train/'${array[$i]}
		FILE2='/home/ubuntu/raw/train/'${array[$(( i + 1 ))]}
		FILE3='/home/ubuntu/raw/train/'${array[$(( i + 2 ))]}
		FILE4='/home/ubuntu/raw/train/'${array[$(( i + 3 ))]}
		if [[ -f $FILE1 ]] && [[ -f $FILE2 ]] && [[ -f $FILE3 ]] && [[ -f $FILE4 ]]
		then
			echo "Pairs found....."
			bkgd_optim 0 $FILE1 & 
			bkgd_optim 1 $FILE2 &
			bkgd_optim 2 $FILE3 &
			bkgd_optim 3 $FILE4 &
			wait
		fi
	done
