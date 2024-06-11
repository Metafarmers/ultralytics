from ultralytics import YOLO, checks, hub
checks()

hub.login('18b2d937cf0ed370aceba118601b1bc30e7fd219e9')

model = YOLO('https://hub.ultralytics.com/models/GyXxzl7k8f4BG437MtKb')

results = model.train()