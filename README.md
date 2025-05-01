# NSAI
# Hybrid AI for Aerial Object Detection: A NeuroSymbolic Approach

This project presents a **hybrid AI pipeline** that combines neural networks (YOLOv8n-OBB) with symbolic reasoning (SWI-Prolog) to enhance object detection in **aerial drone imagery**. It was developed during my internship and explores interpretable and explainable AI methods by bridging deep learning with logical inference.

Using the **DOTA dataset**, the project tackles rotated bounding box detection followed by reasoning over spatial relationships between objects using **Inductive Logic Programming (ILP)** and **Knowledge Graphs**.

# Project Components

## 🔄 Neural Stage: YOLOv8-OBB
- Trained on the DOTA aerial imagery dataset using the YOLOv8n-OBB model.
- Handles rotated bounding box detection for 15 classes (e.g., ships, storage tanks, roundabouts).
- Output detections are exported as Prolog facts (`prolog_facts.pl`) for symbolic reasoning.

## 🔍 Symbolic Stage: Prolog Rule-Based Reasoning
- Uses SWI-Prolog to define rules such as `located_on`, `located_near`, and `adjacent_to`.
- Accepts YOLO detections as input facts and applies rules defined in `rules.pl`.
- Enhances semantic validation by removing false positives or validating object relationships.

## 🔗 Knowledge Graph Construction
- Defined using NetworkX and visualized via Matplotlib in `KG5.py`.
- Models relationships like `"ship located_near harbor"` or `"vehicle adjacent_to bridge"`.
- Prolog facts are generated from the graph to define domain-specific knowledge.

## 📂 Key Files

- `model.py`: Training/validation pipeline for YOLOv8-OBB model.
- `dota.yaml`: Data path and class config for DOTA dataset.
- `categories.json`: Mapping of DOTA object categories.
- `rules.pl`: Logical rules for reasoning over object positions.
- `prolog_facts.pl`: Detected objects exported as facts.
- `allowed_reln.pl`: Lists which object pairs can be adjacent, near, or on each other.
- `KG5.py`: Python script to construct and visualize the knowledge graph.

# DOTA Dataset
- Total Classes: 15
- Sample Categories: Plane, Ship, Storage Tank, Bridge, Roundabout
- Image Format: Satellite/Aerial images with rotated objects

# Tools & Technologies
- Python 3.10
- Ultralytics YOLOv8
- NetworkX + Matplotlib (Knowledge Graph)
- SWI-Prolog (Symbolic Reasoning)
- OpenCV, NumPy

# Future Work
- Add fuzzy logic layer to handle ambiguous spatial overlaps.
- Incorporate temporal rules for object tracking over time.
- Integrate explainability modules (e.g., Grad-CAM + Rule Explanation).
- Optimize Prolog engine using tabling for scalability.


