import networkx as nx
import matplotlib.pyplot as plt
import os


G = nx.DiGraph()

categories = [
    "plane", "ship", "storage_tank", "baseball_diamond", "tennis_court",
    "basketball_court", "Ground_Track_Field", "harbor", "Bridge",
    "large_vehicle", "small_vehicle", "helicopter", "roundabout",
    "soccer_ball_field", "swimming_pool"
]

G.add_nodes_from(categories)

relationships = [
    ("tennis_court", "basketball_court", "Adjacent to"),
    ("baseball_diamond", "soccer_ball_field", "Adjacent to"),
    ("swimming_pool", "Ground_Track_Field", "Adjacent to"),
    ("ship", "harbor", "Located near"),
    ("large_vehicle", "small_vehicle", "Located near"),
    ("large_vehicle", "small_vehicle", "Adjacent to"),
    ("large_vehicle", "Bridge", "Located on"),
    ("plane", "plane", "Adjacent to"),
    ("helicopter", "plane", "Located near"),
    ("small_vehicle", "roundabout", "Located near"),
    ("roundabout", "small_vehicle", "Located near"),
    ("storage_tank", "harbor", "Located near"),
    ("small_vehicle", "tennis_court", "Located near"),
    ("small_vehicle", "basketball_court", "Located near"),
    ("small_vehicle", "soccer_ball_field", "Located near"),
    ("small_vehicle", "Ground_Track_Field", "Located near"),
    ("small_vehicle", "baseball_diamond", "Located near"),
]


for source, target, relation in relationships:
    G.add_edge(source, target, relationship=relation)


output_file = os.path.join(os.getcwd(), "facts.pl")

try:
    with open(output_file, "w") as file:
     
        for node, attrs in G.nodes(data=True):
            file.write(f'category("{node}").\n')
            for attr, value in attrs.items():
                file.write(f'{attr}("{node}", "{value}").\n')

        for source, target, data in G.edges(data=True):
            relation = data['relationship']
            file.write(f'relationship("{source}", "{target}", "{relation}").\n')

    print(f"Facts successfully written to {os.path.abspath(output_file)}")
except Exception as e:
    print(f"An error occurred while writing to the file: {e}")


plt.figure(figsize=(16, 12))
pos = nx.circular_layout(G)  
node_colors = ['skyblue' for _ in G]  

nx.draw(
    G, pos, with_labels=True, node_size=3000,
    node_color=node_colors, font_size=10, font_weight='bold', edge_color="gray"
)

edge_labels = nx.get_edge_attributes(G, 'relationship')
edge_label_pos = {key: (value[0]*1.05, value[1]*1.05) for key, value in pos.items()}
nx.draw_networkx_edge_labels(
    G, pos, edge_labels=edge_labels, font_color='red', font_size=8, bbox=dict(facecolor='white', edgecolor='none')
)

plt.title("Knowledge Graph for DOTA Dataset", fontsize=18)
plt.show()
