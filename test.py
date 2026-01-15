import h5py

def print_h5_structure(file_path):
    with h5py.File(file_path, 'r') as f:
        def print_name(obj, path=''):  # 递归打印文件结构
            if path:
                path += '/'
            path += obj.name
            if isinstance(obj, h5py.Group):
                print(f"Group: {path}")
            elif isinstance(obj, h5py.Dataset):
                print(f"Dataset: {path}, Shape: {obj.shape}, Dtype: {obj.dtype}")

        f.visititems(print_name)

# 替换为你的 .h5 文件路径
file_path = 'F:\\VSCode\\Code\\Python\\nio-main\\nio-main\\Problems\\BodyEIT_Comp_out.h5'
print_h5_structure(file_path)

