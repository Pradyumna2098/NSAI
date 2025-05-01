pip install ultralytics
import os
import subprocess
from ultralytics import YOLO

def install_dependencies():
    """Install YOLOv8 and YOLOv11"""
    subprocess.run(["pip", "install", "ultralytics"])

def train_model():
    model_v8 = YOLO('yolov8n-obb.pt')  

    
    model_v8.train(
        data='/kaggle/input/dota15c/dota.yaml',  
        epochs=50,
        imgsz=1024,
        batch=8,
        workers=0,
        name='dota_experiment_v810241',
        save=True,  
        save_txt=True     
    )

    
    model_v8.val(
        data='/kaggle/input/dota15c/dota.yaml',
        imgsz=1024,
        save=True,  
        save_txt=True  
    )

def save_and_download_results():
    """Save and download results"""
    result_dir = "/kaggle/working/yolo/obb_result"
    os.makedirs(result_dir, exist_ok=True)

    subprocess.run(["cp", "-r", "/kaggle/working/runs/train/dota_experiment_v810241", result_dir])

    print(f"Results saved to {result_dir}")
    return result_dir

if __name__ == "__main__":
    install_dependencies() 
    train_model()  
    results_path = save_and_download_results() 
    print(f"Download results from: {results_path}")
