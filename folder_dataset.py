from PIL import Image
from torch.utils.data import Dataset

class MultiResolutionDataset(Dataset):
    def __init__(self, path, transform, resolution=256):
        
        self.files = gather_files(args.BASE_DIR)
        self.length = len(self.files)
        self.resolution = resolution
        self.transform = transform

    def __len__(self):
        return self.length

    def __getitem__(self, index):
        path = self.files[index]
        img = Image.open(path).convert("RGB")
        img = self.transform(img)

        return img

def gather_files(image_dir):

    images = os.listdir(image_dir)
    images = [
        os.path.join(image_dir, image)
        for image in images]

    return images

