#Target Group Configurations

#Private Client Mixed ASG Target Group
resource "aws_lb_target_group" "private_mixed_asg_tg" {
    name     = "private-client-mixed-asg-tg"
    target_type = "instance"
    port     = 80
    protocol = "HTTP" # Target group must use HTTP or HTTPS protocol if attached to an Application Load Balancer (ALB only supports Layer 7; HTTP and HTTPS).
    protocol_version = "HTTP1" # Required when protocol is HTTP or HTTPS. Default is HTTP1 but you can specify GRPC or HTTP2 if needed.
    vpc_id   = aws_vpc.main.id

    load_balancing_algorithm_type = "round_robin"
    load_balancing_cross_zone_enabled = true
    
    # Health Check Configuration
    health_check {
        enabled = true
        healthy_threshold = 3
        interval = 30
        path = "/" # For HTTP and HTTPS health checks, the default is "/". For gRPC health checks, the default is "/AWS.ALB/healthcheck".
        port = "80"
        protocol = "HTTP" # TCP (Layer 4) is not supported for health checks if the protocol of the target group is HTTP or HTTPS (Layer 7). This is a mismatch and won't work.
        timeout = 6
        unhealthy_threshold = 3
    }
}

# EVERYTHING LAUNCHED FINE BUT TARGET GROUP WASN'T REGISTERED
# FIND OUT HOW TO REGISTER TARGET GROUP

# OVERRIDES FOR LAUNCH TEMPLATE NOT WORKING AS EXPECTED.
# AP NORTHEAST A SHOWS SCRIPT A (T2.NANO)

# AP NORTHEAST B SHOWS SCRIPT C (T3.NANO) PROBLEM. SKIPPED ONE.
# AP NORTHEAST C SHOWS SCRIPT C (T3.NANO)
# NAMES BOTH PRIVATE CLIENT C AND LAUNCHES FROM SAME TEMPLATE

# TEMPLATE USING T2.MICRO (TEMPLATE FOR CLIENT B) WAS NEVER USED