from setuptools import setup

setup(
    name="guided-diffusion-us",
    py_modules=["guided_diffusion"],
    install_requires=["blobfile>=1.0.5", "torch", "tqdm"],
)
