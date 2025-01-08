# guided-diffusion-us

## Architecture
The current one can take care of the 3-channel input/output by setting
- `--in_channels 3 --dataset_type ultrasound_3c`,

and the 1-channel input/output by setting
- `--in_channels 1 --dataset_type ultrasound_1c`. 

#### code modification for the 1-channel case
- In `unet.py`(line616), a 1 X 1 CNN layer was added to the end of the entire model to be the final output layer.

- In `train_util.py`(line118-122): the loaded weihts of the input layer (`model.input_blocks[0][0]`) is summed along the channel dimension, and `model.load_state_dict(state_dict, strict=False)` loads what we can from a pre-trained Net's state dictionary, which allows fine tuning from either a 1-channel or a 3-channel checkpoint.

## Ultrasound Datasets for Fine-Tuning
Based on the [ImageNet pre-trained diffusion model](https://openaipublic.blob.core.windows.net/diffusion/jul-2021/256x256_diffusion_uncond.pt) downloaded from [here](https://github.com/openai/guided-diffusion), we've trained 3 ultrasound diffusion models with 6000, 400, and 500 steps respectively on different datasets. These train sets for each model can be found in the folder "datasets". All of the ultrasound images were aqcuired with around 60-100 plane waves.

## Other notes:
#### Environment
- .sif in this repository is newer than that in the guided-diffusion repository. The new one has an h5py python package for loading the ultrasound datasets

- environment.yml (tested on HPC) corresponds to the .sif file
#### The way to check the parameters of a specific layer
For example, we have a model loaded from torchvison
```
import torchvision
resnet_50 = torchvision.models.resnet50()  # weights are also initialized (exist) in this step
```
In Pycharm, we can view resnet_50 and get the knowledge of the layernames. 
```
print(resnet_50.layer1[0].conv1)  # print the structure info. of layer1 > 0 > conv1 of resnet_50
```
```
weights = resnet_50.state_dict()['layer1.0.conv1.weight']  # get the weight info. of the specififed layer from resnet_50's state dictionary
```
The way the weights tensor is organized in Torch is [out_channels, in_channels, kernel_height, kernel_width].

