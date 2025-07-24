## ✅ **Overall Infrastructure Design**

This infrastructure creates:

* A custom VPC with 2 public subnets in 2 Availability Zones
* A security group allowing all traffic (for simplicity/demo)
* 2 EC2 instances (App-1 and App-2), each in separate subnets
* Elastic IPs (EIPs) associated with each EC2 instance
* An internal **Application Load Balancer** (ALB) with **path-based routing** for `/app-1` and `/app-2`

---

## 🔹 **Terraform Structure**

| File/Module               | Purpose                                                         |
| ------------------------- | --------------------------------------------------------------- |
| `main.tf`                 | Declares providers and composes modules                         |
| `output.tf`               | Defines the output variables                                    |
| `modules/vpc/`            | Creates VPC, subnets, IGW, route tables, NICs, and EIPs         |
| `modules/security_group/` | Defines security group with open ingress/egress                 |
| `modules/app-1/`          | Launches App-1 EC2 instance with user-data                      |
| `modules/app-2/`          | Launches App-2 EC2 instance with user-data                      |
| `modules/alb/`            | Sets up internal ALB with listener rules for path-based routing |

---

## 🧩 **Main Components Explained**

### 🔸 1. **VPC Module (`modules/vpc/`)**

Creates:

* `VPC` with CIDR `172.168.0.0/16`
* Two subnets:

  * `172.168.0.0/24` in `us-east-1a`
  * `172.168.1.0/24` in `us-east-1c`
* `Internet Gateway (IGW)` attached to the VPC
* A single `Route Table` that routes `0.0.0.0/0` to the IGW (assumes public subnets)
* Associates both subnets with this route table
* Creates `ENIs (Elastic Network Interfaces)` for app-1 and app-2 and assigns EIPs

🔹 **Purpose**: To provide public connectivity and isolation between instances.

---

### 🔸 2. **Security Group Module (`modules/security_group/`)**

Creates:

* A **single Security Group** allowing all **inbound and outbound traffic** (`from_port = 0`, `to_port = 0`, `protocol = -1`, `cidr_blocks = ["0.0.0.0/0"]`)

⚠️ **Risk Note**: This allows **any traffic from anywhere**, which is insecure for production. It’s acceptable for testing.

---

### 🔸 3. **AMI & Key Pair**

```hcl
data "aws_ami" "ec2_ami"
```

* Dynamically fetches the latest Amazon Linux 2 AMI
* Generates a TLS key pair (`tls_private_key`)
* Registers the public key as a **Key Pair** in AWS

---

### 🔸 4. **App-1 & App-2 Modules**

Each app module:

* Launches a `t2.micro` instance using the shared AMI and key pair
* Uses the corresponding ENI from the VPC module
* Installs NGINX via user data and creates:

  * `/usr/share/nginx/html/app-1/index.html` with content `"This is app-1"` or `"This is app-2"`

🔹 **User Data** ensures the web server is ready on boot.

---

### 🔸 5. **ALB Module (`modules/alb/`)**

Creates:

* **Internal ALB** (no public DNS)
* Attached to both subnets
* Associated with the security group
* Two **Target Groups**: One for each EC2 instance
* Listener on port 80 with default response `404 Not Found`
* **Listener Rules**:

  * `/app-1` path routes to App-1 target group
  * `/app-2` path routes to App-2 target group

🔹 **Purpose**: Routes requests like `http://<ALB-DNS>/app-1` to App-1 and `/app-2` to App-2

---

## 🧠 **How It All Works Together**

1. VPC provides the network environment.
2. Subnets in two AZs ensure HA/fault tolerance.
3. Two EC2 instances (App-1 and App-2) are deployed in different subnets.
4. An ALB in front routes traffic based on path pattern.
5. Security group allows full access (for testing only).
6. Elastic IPs allow you to SSH into EC2s if needed.

---

## ✅ Pros

* **Modular design** — easy to reuse and maintain
* **Dynamic AMI retrieval** — always uses the latest Amazon Linux 2
* **Infrastructure as Code (IaC)** — reproducible environment
* **Path-based routing** — efficient service separation via ALB

---

## ⚠️ Recommendations for Production Use

| Concern                       | Recommendation                                                |
| ----------------------------- | ------------------------------------------------------------- |
| Security Group too permissive | Restrict by port (e.g., allow only port 22/80 from known IPs) |
| Internal ALB only             | Use `internal = false` for public access (if desired)         |
| No health checks              | Add ALB target group health checks for better resilience      |
| No auto-scaling               | Consider EC2 Auto Scaling groups with target groups           |
| No output for ALB DNS         | Add `output` for `aws_lb.main_lb.dns_name`                    |

---

## 🔚 Summary

This Terraform setup builds a small, complete web infrastructure on AWS:

```
User → ALB (Path-Based) → EC2 App-1 or App-2 (NGINX) → Response
```

It demonstrates:

* Modular infrastructure design
* Load balancing
* Dynamic provisioning of resources