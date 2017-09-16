# Creating an ingress
This creates an ingress controller that manages an nginx load balancer that
will be configured automatically using an `Ingress` resources.

Requests directed to nodes running the ingress controller will be
handled by the ingress controller. By default, requests will be routed
to a default 404 backend. Requests matching a specified path will be
routed to the appropriate `Service` within the k8s cluster.

