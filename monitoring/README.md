# Setting up Prometheus for monitoring
This  automatically deploys a Prometheus resource in the rackspace-monitoring namespace and the 
Prometheus operator in the rackspace-system namespace when the cluster is bootstrapped.

See the [operator README](https://github.com/coreos/prometheus-operator/blob/master/README.md)
for additional details.

![architecture](images/prometheus-architecture.png)
Image credit: https://coreos.com/operators/prometheus/docs/latest/user-guides/images/architecture.png

---
To view the Prometheus dashboard in a web browser:
```
$ open http://<IngressControllerIP>:30080/monitor
```

To view the Alert Manager dashboard in a web browser:
```
$ open http://<IngressControllerIP>:30080/alert
```

---

# Configuring the demo application for monitoring
The demo application consistes of two parts:
* monitored-app - the app to monitor
* monitored-app-service-monitor - the service monitor

The demo app assumes that you run the app in tye default-namespace. Any service monitor you develop inlcuding the 
one for the demo app need to be deployed into the rackspace-monitoring namespace to run in the same namespace as
the prometheus resource.

To start this run:
```
kubectl apply -f tests/manifests/monitored-app.yaml -n default
kubectl apply -f tests/manifests/monitored-app-service-monitor.yaml -n rackspace-monitoring
```

Now you should see the metrics in the web app.

# Configure the alert manager
There is a demo alert which can be triggered:
```
kubectl apply -f tests/manifests/alertmanager-rule.yaml -n rackspace-monitoring
```

The system is set up to do not much alerting so in a production setting you would need to modify
monitoring/alertmanager and re-apply this secret. Please consult https://prometheus.io/docs/alerting/configuration/
for more information.

To apply your modified file:
```
kubectl apply secret generic alertmanager-alert-manager --from-file=alertmanager.yaml -n rackspace-monitoring
```

# Troubleshooting
You can get/describe the prometheus resource and the service monitor resource for more insight.

I also found it useful to review the prometheus resource configuration for further information:
```
$  kubectl exec  prometheus-prometheus-0 -it  cat /etc/prometheus/config/prometheus.yaml
```

With a lot of the system relying on labels make sure that they all match up correctly:
* The service monitor needs the label "monitor: rackspace-prometheus" to be detected by the
  prometheus resource
* The service monitors selector labels and namespace needs to match with the application's service's ones.
  The endpoints names also need to match.
* Verify that your service discovered the endpoints by describing the service or the endpoint.
* Of course the endpoint should emit metrics
* Review the logs of the alert-manager to catch problems with the configuration file



