## Graph Structure Fusion for Multiview Clustering
Most existing multiview clustering methods take graphs, which are usually predefined independently in each view, as input to uncover data distribution. These methods ignore the correlation of graph structure among multiple views and clustering results highly depend on the quality of predefined affinity graphs. We address the problem of multiview clustering by seamlessly integrating graph structures of different views to fully exploit the geometric property of underlying data structure. The proposed method is based on the assumption that the intrinsic underlying graph structure would assign corresponding connected component in each graph to the same cluster. Different graphs from multiple views are integrated by using the Hadamard product since different views usually together admit the same underlying structure across multiple views. Specifically, these graphs are integrated into a global one and the structure of the global graph is adaptively tuned by a well-designed objective function so that the number of components of the graph is exactly equal to the number of clusters. It is worth noting that we directly obtain cluster indicators from the graph itself without performing further graph-cut or k-means clustering algorithms. Experiments show the proposed method obtains better clustering performance than the state-of-the-art methods.


## Citation
We appreciate it if you cite the following paper:
```
@Article{Zhan8052206,
  author =  {Kun Zhan and Chaoxi Niu and Changlu Chen and Feiping Nie and Changqing Zhang and Yi Yang},
  title =   {Graph structure fusion for multiview clustering},
  journal = {IEEE Transactions on Knowledge and Data Engineering},
  year =    {2019},
  volume =  {31},
  number =  {10},
  pages =   {1984--1993},
  doi =     {https://doi.org/10.1109/TKDE.2018.2872061},
  issn =    {1041-4347}
}

```
<a href="https://doi.org/10.1109/TKDE.2018.2872061"><img src="https://zenodo.org/badge/DOI/10.1109/TKDE.2018.2872061.svg" alt="DOI"></a>

## Contact
http://www.escience.cn/people/kzhan

If you have any questions, feel free to contact me. (Email: `ice.echo#gmail.com`)