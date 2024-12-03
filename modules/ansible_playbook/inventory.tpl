[all]
%{ for manager in managers }
manager-${manager} ansible_host=${manager} ansible_user=azureuser
%{ endfor }

%{ for worker in workers }
worker-${worker} ansible_host=${worker} ansible_user=azureuser
%{ endfor }

[kube_control_plane]
%{ for manager in managers }
manager-${manager}
%{ endfor }

[etcd]
%{ for manager in managers }
manager-${manager}
%{ endfor }

[kube_node]
%{ for worker in workers }
worker-${worker}
%{ endfor }

[k8s_cluster:children]
kube_control_plane
kube_node