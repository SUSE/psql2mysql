-- MySQL dump 10.16  Distrib 10.2.15-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: neutron
-- ------------------------------------------------------
-- Server version	10.2.15-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address_scopes`
--

DROP TABLE IF EXISTS `address_scopes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address_scopes` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `shared` tinyint(1) NOT NULL,
  `ip_version` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_address_scopes_project_id` (`project_id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`shared` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address_scopes`
--

LOCK TABLES `address_scopes` WRITE;
/*!40000 ALTER TABLE `address_scopes` DISABLE KEYS */;
/*!40000 ALTER TABLE `address_scopes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `agents`
--

DROP TABLE IF EXISTS `agents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `agents` (
  `id` varchar(36) NOT NULL,
  `agent_type` varchar(255) NOT NULL,
  `binary` varchar(255) NOT NULL,
  `topic` varchar(255) NOT NULL,
  `host` varchar(255) NOT NULL,
  `admin_state_up` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL,
  `started_at` datetime NOT NULL,
  `heartbeat_timestamp` datetime NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `configurations` varchar(4095) NOT NULL,
  `load` int(11) NOT NULL DEFAULT 0,
  `availability_zone` varchar(255) DEFAULT NULL,
  `resource_versions` varchar(8191) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_agents0agent_type0host` (`agent_type`,`host`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`admin_state_up` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `agents`
--

LOCK TABLES `agents` WRITE;
/*!40000 ALTER TABLE `agents` DISABLE KEYS */;
INSERT INTO `agents` VALUES ('49575f44-c5c0-42d3-8a49-1e87827ea23b','Open vSwitch agent','neutron-openvswitch-agent','N/A','aojea-devstack-leap15',1,'2018-09-05 14:40:40','2018-09-05 14:40:40','2018-09-07 07:24:13',NULL,'{\"arp_responder_enabled\": false, \"bridge_mappings\": {\"public\": \"br-ex\"}, \"datapath_type\": \"system\", \"devices\": 0, \"enable_distributed_routing\": false, \"extensions\": [], \"in_distributed_mode\": false, \"l2_population\": false, \"log_agent_heartbeats\": false, \"ovs_capabilities\": {\"datapath_types\": [\"netdev\", \"system\"], \"iface_types\": [\"geneve\", \"gre\", \"internal\", \"lisp\", \"patch\", \"stt\", \"system\", \"tap\", \"vxlan\"]}, \"ovs_hybrid_plug\": false, \"tunnel_types\": [\"vxlan\"], \"tunneling_ip\": \"127.0.0.1\", \"vhostuser_socket_dir\": \"/var/run/openvswitch\"}',0,NULL,'{\"Log\": \"1.0\", \"Network\": \"1.0\", \"Port\": \"1.4\", \"PortForwarding\": \"1.0\", \"QosPolicy\": \"1.7\", \"SecurityGroup\": \"1.0\", \"SecurityGroupRule\": \"1.0\", \"SubPort\": \"1.0\", \"Subnet\": \"1.0\", \"Trunk\": \"1.1\"}'),('771e29d4-1b5c-4946-b7f6-b9dae0d1b158','DHCP agent','neutron-dhcp-agent','dhcp_agent','aojea-devstack-leap15',1,'2018-09-05 14:40:35','2018-09-05 14:40:35','2018-09-07 07:24:07',NULL,'{\"dhcp_driver\": \"neutron.agent.linux.dhcp.Dnsmasq\", \"dhcp_lease_duration\": 86400, \"log_agent_heartbeats\": false, \"networks\": 1, \"ports\": 3, \"subnets\": 2}',1,'nova',NULL),('ba2b379e-d9ea-4787-9a38-5331c1f8eaa5','L3 agent','neutron-l3-agent','l3_agent','aojea-devstack-leap15',1,'2018-09-05 14:40:38','2018-09-05 14:40:38','2018-09-07 07:24:10',NULL,'{\"agent_mode\": \"legacy\", \"ex_gw_ports\": 1, \"external_network_bridge\": \"\", \"floating_ips\": 0, \"gateway_external_network_id\": \"\", \"handle_internal_only_routers\": true, \"interface_driver\": \"openvswitch\", \"interfaces\": 2, \"log_agent_heartbeats\": false, \"routers\": 1}',0,'nova',NULL),('cec65826-9b26-425e-a379-81dcba15fe9d','Metadata agent','neutron-metadata-agent','N/A','aojea-devstack-leap15',1,'2018-09-05 14:40:40','2018-09-05 14:40:40','2018-09-07 07:24:07',NULL,'{\"log_agent_heartbeats\": false, \"metadata_proxy_socket\": \"/opt/stack/data/neutron/metadata_proxy\", \"nova_metadata_host\": \"127.0.0.1\", \"nova_metadata_port\": 8775}',0,NULL,NULL);
/*!40000 ALTER TABLE `agents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `alembic_version`
--

DROP TABLE IF EXISTS `alembic_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alembic_version`
--

LOCK TABLES `alembic_version` WRITE;
/*!40000 ALTER TABLE `alembic_version` DISABLE KEYS */;
INSERT INTO `alembic_version` VALUES ('5c85685d616d'),('867d39095bf4');
/*!40000 ALTER TABLE `alembic_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `allowedaddresspairs`
--

DROP TABLE IF EXISTS `allowedaddresspairs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `allowedaddresspairs` (
  `port_id` varchar(36) NOT NULL,
  `mac_address` varchar(32) NOT NULL,
  `ip_address` varchar(64) NOT NULL,
  PRIMARY KEY (`port_id`,`mac_address`,`ip_address`),
  CONSTRAINT `allowedaddresspairs_ibfk_1` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `allowedaddresspairs`
--

LOCK TABLES `allowedaddresspairs` WRITE;
/*!40000 ALTER TABLE `allowedaddresspairs` DISABLE KEYS */;
/*!40000 ALTER TABLE `allowedaddresspairs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `arista_provisioned_nets`
--

DROP TABLE IF EXISTS `arista_provisioned_nets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arista_provisioned_nets` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `network_id` varchar(36) DEFAULT NULL,
  `segmentation_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_arista_provisioned_nets_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arista_provisioned_nets`
--

LOCK TABLES `arista_provisioned_nets` WRITE;
/*!40000 ALTER TABLE `arista_provisioned_nets` DISABLE KEYS */;
/*!40000 ALTER TABLE `arista_provisioned_nets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `arista_provisioned_tenants`
--

DROP TABLE IF EXISTS `arista_provisioned_tenants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arista_provisioned_tenants` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_arista_provisioned_tenants_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arista_provisioned_tenants`
--

LOCK TABLES `arista_provisioned_tenants` WRITE;
/*!40000 ALTER TABLE `arista_provisioned_tenants` DISABLE KEYS */;
/*!40000 ALTER TABLE `arista_provisioned_tenants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `arista_provisioned_vms`
--

DROP TABLE IF EXISTS `arista_provisioned_vms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `arista_provisioned_vms` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `vm_id` varchar(255) DEFAULT NULL,
  `host_id` varchar(255) DEFAULT NULL,
  `port_id` varchar(36) DEFAULT NULL,
  `network_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_arista_provisioned_vms_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arista_provisioned_vms`
--

LOCK TABLES `arista_provisioned_vms` WRITE;
/*!40000 ALTER TABLE `arista_provisioned_vms` DISABLE KEYS */;
/*!40000 ALTER TABLE `arista_provisioned_vms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auto_allocated_topologies`
--

DROP TABLE IF EXISTS `auto_allocated_topologies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auto_allocated_topologies` (
  `project_id` varchar(255) NOT NULL,
  `network_id` varchar(36) NOT NULL,
  `router_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`project_id`),
  KEY `network_id` (`network_id`),
  KEY `router_id` (`router_id`),
  CONSTRAINT `auto_allocated_topologies_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `auto_allocated_topologies_ibfk_2` FOREIGN KEY (`router_id`) REFERENCES `routers` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auto_allocated_topologies`
--

LOCK TABLES `auto_allocated_topologies` WRITE;
/*!40000 ALTER TABLE `auto_allocated_topologies` DISABLE KEYS */;
/*!40000 ALTER TABLE `auto_allocated_topologies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bgp_peers`
--

DROP TABLE IF EXISTS `bgp_peers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bgp_peers` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `auth_type` varchar(16) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `peer_ip` varchar(64) NOT NULL,
  `remote_as` int(11) NOT NULL,
  `tenant_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_bgp_peers_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bgp_peers`
--

LOCK TABLES `bgp_peers` WRITE;
/*!40000 ALTER TABLE `bgp_peers` DISABLE KEYS */;
/*!40000 ALTER TABLE `bgp_peers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bgp_speaker_dragent_bindings`
--

DROP TABLE IF EXISTS `bgp_speaker_dragent_bindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bgp_speaker_dragent_bindings` (
  `agent_id` varchar(36) NOT NULL,
  `bgp_speaker_id` varchar(36) NOT NULL,
  PRIMARY KEY (`agent_id`),
  KEY `bgp_speaker_id` (`bgp_speaker_id`),
  CONSTRAINT `bgp_speaker_dragent_bindings_ibfk_1` FOREIGN KEY (`agent_id`) REFERENCES `agents` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bgp_speaker_dragent_bindings_ibfk_2` FOREIGN KEY (`bgp_speaker_id`) REFERENCES `bgp_speakers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bgp_speaker_dragent_bindings`
--

LOCK TABLES `bgp_speaker_dragent_bindings` WRITE;
/*!40000 ALTER TABLE `bgp_speaker_dragent_bindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `bgp_speaker_dragent_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bgp_speaker_network_bindings`
--

DROP TABLE IF EXISTS `bgp_speaker_network_bindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bgp_speaker_network_bindings` (
  `bgp_speaker_id` varchar(36) NOT NULL,
  `network_id` varchar(36) NOT NULL,
  `ip_version` int(11) NOT NULL,
  PRIMARY KEY (`network_id`,`bgp_speaker_id`,`ip_version`),
  KEY `bgp_speaker_id` (`bgp_speaker_id`),
  CONSTRAINT `bgp_speaker_network_bindings_ibfk_1` FOREIGN KEY (`bgp_speaker_id`) REFERENCES `bgp_speakers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bgp_speaker_network_bindings_ibfk_2` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bgp_speaker_network_bindings`
--

LOCK TABLES `bgp_speaker_network_bindings` WRITE;
/*!40000 ALTER TABLE `bgp_speaker_network_bindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `bgp_speaker_network_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bgp_speaker_peer_bindings`
--

DROP TABLE IF EXISTS `bgp_speaker_peer_bindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bgp_speaker_peer_bindings` (
  `bgp_speaker_id` varchar(36) NOT NULL,
  `bgp_peer_id` varchar(36) NOT NULL,
  PRIMARY KEY (`bgp_speaker_id`,`bgp_peer_id`),
  KEY `bgp_peer_id` (`bgp_peer_id`),
  CONSTRAINT `bgp_speaker_peer_bindings_ibfk_1` FOREIGN KEY (`bgp_speaker_id`) REFERENCES `bgp_speakers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bgp_speaker_peer_bindings_ibfk_2` FOREIGN KEY (`bgp_peer_id`) REFERENCES `bgp_peers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bgp_speaker_peer_bindings`
--

LOCK TABLES `bgp_speaker_peer_bindings` WRITE;
/*!40000 ALTER TABLE `bgp_speaker_peer_bindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `bgp_speaker_peer_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bgp_speakers`
--

DROP TABLE IF EXISTS `bgp_speakers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bgp_speakers` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `local_as` int(11) NOT NULL,
  `ip_version` int(11) NOT NULL,
  `tenant_id` varchar(255) DEFAULT NULL,
  `advertise_floating_ip_host_routes` tinyint(1) NOT NULL,
  `advertise_tenant_networks` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_bgp_speakers_tenant_id` (`tenant_id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`advertise_floating_ip_host_routes` in (0,1)),
  CONSTRAINT `CONSTRAINT_2` CHECK (`advertise_tenant_networks` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bgp_speakers`
--

LOCK TABLES `bgp_speakers` WRITE;
/*!40000 ALTER TABLE `bgp_speakers` DISABLE KEYS */;
/*!40000 ALTER TABLE `bgp_speakers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brocadenetworks`
--

DROP TABLE IF EXISTS `brocadenetworks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `brocadenetworks` (
  `id` varchar(36) NOT NULL,
  `vlan` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brocadenetworks`
--

LOCK TABLES `brocadenetworks` WRITE;
/*!40000 ALTER TABLE `brocadenetworks` DISABLE KEYS */;
/*!40000 ALTER TABLE `brocadenetworks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `brocadeports`
--

DROP TABLE IF EXISTS `brocadeports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `brocadeports` (
  `port_id` varchar(36) NOT NULL DEFAULT '',
  `network_id` varchar(36) NOT NULL,
  `admin_state_up` tinyint(1) NOT NULL,
  `physical_interface` varchar(36) DEFAULT NULL,
  `vlan_id` varchar(36) DEFAULT NULL,
  `tenant_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`port_id`),
  KEY `network_id` (`network_id`),
  CONSTRAINT `brocadeports_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `brocadenetworks` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`admin_state_up` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `brocadeports`
--

LOCK TABLES `brocadeports` WRITE;
/*!40000 ALTER TABLE `brocadeports` DISABLE KEYS */;
/*!40000 ALTER TABLE `brocadeports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cisco_csr_identifier_map`
--

DROP TABLE IF EXISTS `cisco_csr_identifier_map`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cisco_csr_identifier_map` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `ipsec_site_conn_id` varchar(36) NOT NULL,
  `csr_tunnel_id` int(11) NOT NULL,
  `csr_ike_policy_id` int(11) NOT NULL,
  `csr_ipsec_policy_id` int(11) NOT NULL,
  PRIMARY KEY (`ipsec_site_conn_id`),
  CONSTRAINT `cisco_csr_identifier_map_ibfk_1` FOREIGN KEY (`ipsec_site_conn_id`) REFERENCES `ipsec_site_connections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cisco_csr_identifier_map`
--

LOCK TABLES `cisco_csr_identifier_map` WRITE;
/*!40000 ALTER TABLE `cisco_csr_identifier_map` DISABLE KEYS */;
/*!40000 ALTER TABLE `cisco_csr_identifier_map` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cisco_hosting_devices`
--

DROP TABLE IF EXISTS `cisco_hosting_devices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cisco_hosting_devices` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `complementary_id` varchar(36) DEFAULT NULL,
  `device_id` varchar(255) DEFAULT NULL,
  `admin_state_up` tinyint(1) NOT NULL,
  `management_port_id` varchar(36) DEFAULT NULL,
  `protocol_port` int(11) DEFAULT NULL,
  `cfg_agent_id` varchar(36) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `status` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cfg_agent_id` (`cfg_agent_id`),
  KEY `management_port_id` (`management_port_id`),
  KEY `ix_cisco_hosting_devices_tenant_id` (`tenant_id`),
  CONSTRAINT `cisco_hosting_devices_ibfk_1` FOREIGN KEY (`cfg_agent_id`) REFERENCES `agents` (`id`),
  CONSTRAINT `cisco_hosting_devices_ibfk_2` FOREIGN KEY (`management_port_id`) REFERENCES `ports` (`id`) ON DELETE SET NULL,
  CONSTRAINT `CONSTRAINT_1` CHECK (`admin_state_up` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cisco_hosting_devices`
--

LOCK TABLES `cisco_hosting_devices` WRITE;
/*!40000 ALTER TABLE `cisco_hosting_devices` DISABLE KEYS */;
/*!40000 ALTER TABLE `cisco_hosting_devices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cisco_ml2_apic_contracts`
--

DROP TABLE IF EXISTS `cisco_ml2_apic_contracts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cisco_ml2_apic_contracts` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `router_id` varchar(36) NOT NULL,
  PRIMARY KEY (`router_id`),
  KEY `ix_cisco_ml2_apic_contracts_tenant_id` (`tenant_id`),
  CONSTRAINT `cisco_ml2_apic_contracts_ibfk_1` FOREIGN KEY (`router_id`) REFERENCES `routers` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cisco_ml2_apic_contracts`
--

LOCK TABLES `cisco_ml2_apic_contracts` WRITE;
/*!40000 ALTER TABLE `cisco_ml2_apic_contracts` DISABLE KEYS */;
/*!40000 ALTER TABLE `cisco_ml2_apic_contracts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cisco_ml2_apic_host_links`
--

DROP TABLE IF EXISTS `cisco_ml2_apic_host_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cisco_ml2_apic_host_links` (
  `host` varchar(255) NOT NULL,
  `ifname` varchar(64) NOT NULL,
  `ifmac` varchar(32) DEFAULT NULL,
  `swid` varchar(32) NOT NULL,
  `module` varchar(32) NOT NULL,
  `port` varchar(32) NOT NULL,
  PRIMARY KEY (`host`,`ifname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cisco_ml2_apic_host_links`
--

LOCK TABLES `cisco_ml2_apic_host_links` WRITE;
/*!40000 ALTER TABLE `cisco_ml2_apic_host_links` DISABLE KEYS */;
/*!40000 ALTER TABLE `cisco_ml2_apic_host_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cisco_ml2_apic_names`
--

DROP TABLE IF EXISTS `cisco_ml2_apic_names`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cisco_ml2_apic_names` (
  `neutron_id` varchar(36) NOT NULL,
  `neutron_type` varchar(32) NOT NULL,
  `apic_name` varchar(255) NOT NULL,
  PRIMARY KEY (`neutron_id`,`neutron_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cisco_ml2_apic_names`
--

LOCK TABLES `cisco_ml2_apic_names` WRITE;
/*!40000 ALTER TABLE `cisco_ml2_apic_names` DISABLE KEYS */;
/*!40000 ALTER TABLE `cisco_ml2_apic_names` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cisco_ml2_n1kv_network_bindings`
--

DROP TABLE IF EXISTS `cisco_ml2_n1kv_network_bindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cisco_ml2_n1kv_network_bindings` (
  `network_id` varchar(36) NOT NULL,
  `network_type` varchar(32) NOT NULL,
  `segmentation_id` int(11) DEFAULT NULL,
  `profile_id` varchar(36) NOT NULL,
  PRIMARY KEY (`network_id`),
  KEY `profile_id` (`profile_id`),
  CONSTRAINT `cisco_ml2_n1kv_network_bindings_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cisco_ml2_n1kv_network_bindings_ibfk_2` FOREIGN KEY (`profile_id`) REFERENCES `cisco_ml2_n1kv_network_profiles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cisco_ml2_n1kv_network_bindings`
--

LOCK TABLES `cisco_ml2_n1kv_network_bindings` WRITE;
/*!40000 ALTER TABLE `cisco_ml2_n1kv_network_bindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `cisco_ml2_n1kv_network_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cisco_ml2_n1kv_network_profiles`
--

DROP TABLE IF EXISTS `cisco_ml2_n1kv_network_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cisco_ml2_n1kv_network_profiles` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `segment_type` enum('vlan','vxlan') NOT NULL,
  `segment_range` varchar(255) DEFAULT NULL,
  `multicast_ip_index` int(11) DEFAULT NULL,
  `multicast_ip_range` varchar(255) DEFAULT NULL,
  `sub_type` varchar(255) DEFAULT NULL,
  `physical_network` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cisco_ml2_n1kv_network_profiles`
--

LOCK TABLES `cisco_ml2_n1kv_network_profiles` WRITE;
/*!40000 ALTER TABLE `cisco_ml2_n1kv_network_profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `cisco_ml2_n1kv_network_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cisco_ml2_n1kv_policy_profiles`
--

DROP TABLE IF EXISTS `cisco_ml2_n1kv_policy_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cisco_ml2_n1kv_policy_profiles` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) NOT NULL,
  `vsm_ip` varchar(16) NOT NULL,
  PRIMARY KEY (`id`,`vsm_ip`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cisco_ml2_n1kv_policy_profiles`
--

LOCK TABLES `cisco_ml2_n1kv_policy_profiles` WRITE;
/*!40000 ALTER TABLE `cisco_ml2_n1kv_policy_profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `cisco_ml2_n1kv_policy_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cisco_ml2_n1kv_port_bindings`
--

DROP TABLE IF EXISTS `cisco_ml2_n1kv_port_bindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cisco_ml2_n1kv_port_bindings` (
  `port_id` varchar(36) NOT NULL,
  `profile_id` varchar(36) NOT NULL,
  PRIMARY KEY (`port_id`),
  CONSTRAINT `cisco_ml2_n1kv_port_bindings_ibfk_1` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cisco_ml2_n1kv_port_bindings`
--

LOCK TABLES `cisco_ml2_n1kv_port_bindings` WRITE;
/*!40000 ALTER TABLE `cisco_ml2_n1kv_port_bindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `cisco_ml2_n1kv_port_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cisco_ml2_n1kv_profile_bindings`
--

DROP TABLE IF EXISTS `cisco_ml2_n1kv_profile_bindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cisco_ml2_n1kv_profile_bindings` (
  `profile_type` enum('network','policy') DEFAULT NULL,
  `tenant_id` varchar(36) NOT NULL DEFAULT 'tenant_id_not_set',
  `profile_id` varchar(36) NOT NULL,
  PRIMARY KEY (`tenant_id`,`profile_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cisco_ml2_n1kv_profile_bindings`
--

LOCK TABLES `cisco_ml2_n1kv_profile_bindings` WRITE;
/*!40000 ALTER TABLE `cisco_ml2_n1kv_profile_bindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `cisco_ml2_n1kv_profile_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cisco_ml2_n1kv_vlan_allocations`
--

DROP TABLE IF EXISTS `cisco_ml2_n1kv_vlan_allocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cisco_ml2_n1kv_vlan_allocations` (
  `physical_network` varchar(64) NOT NULL,
  `vlan_id` int(11) NOT NULL,
  `allocated` tinyint(1) NOT NULL,
  `network_profile_id` varchar(36) NOT NULL,
  PRIMARY KEY (`physical_network`,`vlan_id`),
  KEY `network_profile_id` (`network_profile_id`),
  CONSTRAINT `cisco_ml2_n1kv_vlan_allocations_ibfk_1` FOREIGN KEY (`network_profile_id`) REFERENCES `cisco_ml2_n1kv_network_profiles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`allocated` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cisco_ml2_n1kv_vlan_allocations`
--

LOCK TABLES `cisco_ml2_n1kv_vlan_allocations` WRITE;
/*!40000 ALTER TABLE `cisco_ml2_n1kv_vlan_allocations` DISABLE KEYS */;
/*!40000 ALTER TABLE `cisco_ml2_n1kv_vlan_allocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cisco_ml2_n1kv_vxlan_allocations`
--

DROP TABLE IF EXISTS `cisco_ml2_n1kv_vxlan_allocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cisco_ml2_n1kv_vxlan_allocations` (
  `vxlan_id` int(11) NOT NULL,
  `allocated` tinyint(1) NOT NULL,
  `network_profile_id` varchar(36) NOT NULL,
  PRIMARY KEY (`vxlan_id`),
  KEY `network_profile_id` (`network_profile_id`),
  CONSTRAINT `cisco_ml2_n1kv_vxlan_allocations_ibfk_1` FOREIGN KEY (`network_profile_id`) REFERENCES `cisco_ml2_n1kv_network_profiles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`allocated` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cisco_ml2_n1kv_vxlan_allocations`
--

LOCK TABLES `cisco_ml2_n1kv_vxlan_allocations` WRITE;
/*!40000 ALTER TABLE `cisco_ml2_n1kv_vxlan_allocations` DISABLE KEYS */;
/*!40000 ALTER TABLE `cisco_ml2_n1kv_vxlan_allocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cisco_ml2_nexus_nve`
--

DROP TABLE IF EXISTS `cisco_ml2_nexus_nve`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cisco_ml2_nexus_nve` (
  `vni` int(11) NOT NULL,
  `switch_ip` varchar(255) NOT NULL,
  `device_id` varchar(255) NOT NULL,
  `mcast_group` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`vni`,`switch_ip`,`device_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cisco_ml2_nexus_nve`
--

LOCK TABLES `cisco_ml2_nexus_nve` WRITE;
/*!40000 ALTER TABLE `cisco_ml2_nexus_nve` DISABLE KEYS */;
/*!40000 ALTER TABLE `cisco_ml2_nexus_nve` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cisco_ml2_nexusport_bindings`
--

DROP TABLE IF EXISTS `cisco_ml2_nexusport_bindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cisco_ml2_nexusport_bindings` (
  `binding_id` int(11) NOT NULL AUTO_INCREMENT,
  `port_id` varchar(255) DEFAULT NULL,
  `vlan_id` int(11) NOT NULL,
  `switch_ip` varchar(255) DEFAULT NULL,
  `instance_id` varchar(255) DEFAULT NULL,
  `vni` int(11) DEFAULT NULL,
  `is_provider_vlan` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`binding_id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`is_provider_vlan` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cisco_ml2_nexusport_bindings`
--

LOCK TABLES `cisco_ml2_nexusport_bindings` WRITE;
/*!40000 ALTER TABLE `cisco_ml2_nexusport_bindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `cisco_ml2_nexusport_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cisco_port_mappings`
--

DROP TABLE IF EXISTS `cisco_port_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cisco_port_mappings` (
  `logical_resource_id` varchar(36) NOT NULL,
  `logical_port_id` varchar(36) NOT NULL,
  `port_type` varchar(32) DEFAULT NULL,
  `network_type` varchar(32) DEFAULT NULL,
  `hosting_port_id` varchar(36) DEFAULT NULL,
  `segmentation_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`logical_resource_id`,`logical_port_id`),
  KEY `hosting_port_id` (`hosting_port_id`),
  KEY `logical_port_id` (`logical_port_id`),
  CONSTRAINT `cisco_port_mappings_ibfk_1` FOREIGN KEY (`hosting_port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE,
  CONSTRAINT `cisco_port_mappings_ibfk_2` FOREIGN KEY (`logical_port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cisco_port_mappings`
--

LOCK TABLES `cisco_port_mappings` WRITE;
/*!40000 ALTER TABLE `cisco_port_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `cisco_port_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cisco_router_mappings`
--

DROP TABLE IF EXISTS `cisco_router_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cisco_router_mappings` (
  `router_id` varchar(36) NOT NULL,
  `auto_schedule` tinyint(1) NOT NULL,
  `hosting_device_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`router_id`),
  KEY `hosting_device_id` (`hosting_device_id`),
  CONSTRAINT `cisco_router_mappings_ibfk_1` FOREIGN KEY (`hosting_device_id`) REFERENCES `cisco_hosting_devices` (`id`) ON DELETE SET NULL,
  CONSTRAINT `cisco_router_mappings_ibfk_2` FOREIGN KEY (`router_id`) REFERENCES `routers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`auto_schedule` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cisco_router_mappings`
--

LOCK TABLES `cisco_router_mappings` WRITE;
/*!40000 ALTER TABLE `cisco_router_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `cisco_router_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `consistencyhashes`
--

DROP TABLE IF EXISTS `consistencyhashes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `consistencyhashes` (
  `hash_id` varchar(255) NOT NULL,
  `hash` varchar(255) NOT NULL,
  PRIMARY KEY (`hash_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consistencyhashes`
--

LOCK TABLES `consistencyhashes` WRITE;
/*!40000 ALTER TABLE `consistencyhashes` DISABLE KEYS */;
/*!40000 ALTER TABLE `consistencyhashes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `default_security_group`
--

DROP TABLE IF EXISTS `default_security_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `default_security_group` (
  `project_id` varchar(255) NOT NULL,
  `security_group_id` varchar(36) NOT NULL,
  PRIMARY KEY (`project_id`),
  KEY `security_group_id` (`security_group_id`),
  CONSTRAINT `default_security_group_ibfk_1` FOREIGN KEY (`security_group_id`) REFERENCES `securitygroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `default_security_group`
--

LOCK TABLES `default_security_group` WRITE;
/*!40000 ALTER TABLE `default_security_group` DISABLE KEYS */;
INSERT INTO `default_security_group` VALUES ('','25681359-4a3d-45d9-8006-6d4e0046497e'),('98d33a223ed04ad48871015367f41d19','740a91e2-5a17-4eb3-a4d0-0de72651b2ed'),('7b41e5f1bc3149c9b1dd0c0eded62d11','7b6e9a39-4ea5-476c-8452-9124a5d6c5e7');
/*!40000 ALTER TABLE `default_security_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dnsnameservers`
--

DROP TABLE IF EXISTS `dnsnameservers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dnsnameservers` (
  `address` varchar(128) NOT NULL,
  `subnet_id` varchar(36) NOT NULL,
  `order` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`address`,`subnet_id`),
  KEY `subnet_id` (`subnet_id`),
  CONSTRAINT `dnsnameservers_ibfk_1` FOREIGN KEY (`subnet_id`) REFERENCES `subnets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dnsnameservers`
--

LOCK TABLES `dnsnameservers` WRITE;
/*!40000 ALTER TABLE `dnsnameservers` DISABLE KEYS */;
/*!40000 ALTER TABLE `dnsnameservers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dvr_host_macs`
--

DROP TABLE IF EXISTS `dvr_host_macs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dvr_host_macs` (
  `host` varchar(255) NOT NULL,
  `mac_address` varchar(32) NOT NULL,
  PRIMARY KEY (`host`),
  UNIQUE KEY `mac_address` (`mac_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dvr_host_macs`
--

LOCK TABLES `dvr_host_macs` WRITE;
/*!40000 ALTER TABLE `dvr_host_macs` DISABLE KEYS */;
/*!40000 ALTER TABLE `dvr_host_macs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `externalnetworks`
--

DROP TABLE IF EXISTS `externalnetworks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `externalnetworks` (
  `network_id` varchar(36) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`network_id`),
  CONSTRAINT `externalnetworks_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`is_default` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `externalnetworks`
--

LOCK TABLES `externalnetworks` WRITE;
/*!40000 ALTER TABLE `externalnetworks` DISABLE KEYS */;
INSERT INTO `externalnetworks` VALUES ('f0718f76-f4a7-4549-b54b-5d1826daf9e4',1);
/*!40000 ALTER TABLE `externalnetworks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `extradhcpopts`
--

DROP TABLE IF EXISTS `extradhcpopts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `extradhcpopts` (
  `id` varchar(36) NOT NULL,
  `port_id` varchar(36) NOT NULL,
  `opt_name` varchar(64) NOT NULL,
  `opt_value` varchar(255) NOT NULL,
  `ip_version` int(11) NOT NULL DEFAULT 4,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_extradhcpopts0portid0optname0ipversion` (`port_id`,`opt_name`,`ip_version`),
  CONSTRAINT `extradhcpopts_ibfk_1` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `extradhcpopts`
--

LOCK TABLES `extradhcpopts` WRITE;
/*!40000 ALTER TABLE `extradhcpopts` DISABLE KEYS */;
/*!40000 ALTER TABLE `extradhcpopts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `firewall_policies`
--

DROP TABLE IF EXISTS `firewall_policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `firewall_policies` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `shared` tinyint(1) DEFAULT NULL,
  `audited` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`shared` in (0,1)),
  CONSTRAINT `CONSTRAINT_2` CHECK (`audited` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `firewall_policies`
--

LOCK TABLES `firewall_policies` WRITE;
/*!40000 ALTER TABLE `firewall_policies` DISABLE KEYS */;
/*!40000 ALTER TABLE `firewall_policies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `firewall_rules`
--

DROP TABLE IF EXISTS `firewall_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `firewall_rules` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `firewall_policy_id` varchar(36) DEFAULT NULL,
  `shared` tinyint(1) DEFAULT NULL,
  `protocol` varchar(40) DEFAULT NULL,
  `ip_version` int(11) NOT NULL,
  `source_ip_address` varchar(46) DEFAULT NULL,
  `destination_ip_address` varchar(46) DEFAULT NULL,
  `source_port_range_min` int(11) DEFAULT NULL,
  `source_port_range_max` int(11) DEFAULT NULL,
  `destination_port_range_min` int(11) DEFAULT NULL,
  `destination_port_range_max` int(11) DEFAULT NULL,
  `action` enum('allow','deny') DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `position` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `firewall_rules_ibfk_1` (`firewall_policy_id`),
  CONSTRAINT `firewall_rules_ibfk_1` FOREIGN KEY (`firewall_policy_id`) REFERENCES `firewall_policies` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`shared` in (0,1)),
  CONSTRAINT `CONSTRAINT_2` CHECK (`enabled` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `firewall_rules`
--

LOCK TABLES `firewall_rules` WRITE;
/*!40000 ALTER TABLE `firewall_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `firewall_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `firewalls`
--

DROP TABLE IF EXISTS `firewalls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `firewalls` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `shared` tinyint(1) DEFAULT NULL,
  `admin_state_up` tinyint(1) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `firewall_policy_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `firewalls_ibfk_1` (`firewall_policy_id`),
  CONSTRAINT `firewalls_ibfk_1` FOREIGN KEY (`firewall_policy_id`) REFERENCES `firewall_policies` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`shared` in (0,1)),
  CONSTRAINT `CONSTRAINT_2` CHECK (`admin_state_up` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `firewalls`
--

LOCK TABLES `firewalls` WRITE;
/*!40000 ALTER TABLE `firewalls` DISABLE KEYS */;
/*!40000 ALTER TABLE `firewalls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flavors`
--

DROP TABLE IF EXISTS `flavors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flavors` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `service_type` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`enabled` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flavors`
--

LOCK TABLES `flavors` WRITE;
/*!40000 ALTER TABLE `flavors` DISABLE KEYS */;
/*!40000 ALTER TABLE `flavors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `flavorserviceprofilebindings`
--

DROP TABLE IF EXISTS `flavorserviceprofilebindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `flavorserviceprofilebindings` (
  `service_profile_id` varchar(36) NOT NULL,
  `flavor_id` varchar(36) NOT NULL,
  PRIMARY KEY (`service_profile_id`,`flavor_id`),
  KEY `flavorserviceprofilebindings_ibfk_2` (`flavor_id`),
  CONSTRAINT `flavorserviceprofilebindings_ibfk_1` FOREIGN KEY (`service_profile_id`) REFERENCES `serviceprofiles` (`id`) ON DELETE CASCADE,
  CONSTRAINT `flavorserviceprofilebindings_ibfk_2` FOREIGN KEY (`flavor_id`) REFERENCES `flavors` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `flavorserviceprofilebindings`
--

LOCK TABLES `flavorserviceprofilebindings` WRITE;
/*!40000 ALTER TABLE `flavorserviceprofilebindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `flavorserviceprofilebindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `floatingipdnses`
--

DROP TABLE IF EXISTS `floatingipdnses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `floatingipdnses` (
  `floatingip_id` varchar(36) NOT NULL,
  `dns_name` varchar(255) NOT NULL,
  `dns_domain` varchar(255) NOT NULL,
  `published_dns_name` varchar(255) NOT NULL,
  `published_dns_domain` varchar(255) NOT NULL,
  PRIMARY KEY (`floatingip_id`),
  KEY `ix_floatingipdnses_floatingip_id` (`floatingip_id`),
  CONSTRAINT `floatingipdnses_ibfk_1` FOREIGN KEY (`floatingip_id`) REFERENCES `floatingips` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `floatingipdnses`
--

LOCK TABLES `floatingipdnses` WRITE;
/*!40000 ALTER TABLE `floatingipdnses` DISABLE KEYS */;
/*!40000 ALTER TABLE `floatingipdnses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `floatingips`
--

DROP TABLE IF EXISTS `floatingips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `floatingips` (
  `project_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `floating_ip_address` varchar(64) NOT NULL,
  `floating_network_id` varchar(36) NOT NULL,
  `floating_port_id` varchar(36) NOT NULL,
  `fixed_port_id` varchar(36) DEFAULT NULL,
  `fixed_ip_address` varchar(64) DEFAULT NULL,
  `router_id` varchar(36) DEFAULT NULL,
  `last_known_router_id` varchar(36) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `standard_attr_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_floatingips0standard_attr_id` (`standard_attr_id`),
  UNIQUE KEY `uniq_floatingips0floatingnetworkid0fixedportid0fixedipaddress` (`floating_network_id`,`fixed_port_id`,`fixed_ip_address`),
  KEY `fixed_port_id` (`fixed_port_id`),
  KEY `floating_port_id` (`floating_port_id`),
  KEY `router_id` (`router_id`),
  KEY `ix_floatingips_project_id` (`project_id`),
  CONSTRAINT `floatingips_ibfk_1` FOREIGN KEY (`fixed_port_id`) REFERENCES `ports` (`id`),
  CONSTRAINT `floatingips_ibfk_2` FOREIGN KEY (`floating_port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE,
  CONSTRAINT `floatingips_ibfk_3` FOREIGN KEY (`router_id`) REFERENCES `routers` (`id`),
  CONSTRAINT `floatingips_ibfk_4` FOREIGN KEY (`standard_attr_id`) REFERENCES `standardattributes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `floatingips`
--

LOCK TABLES `floatingips` WRITE;
/*!40000 ALTER TABLE `floatingips` DISABLE KEYS */;
/*!40000 ALTER TABLE `floatingips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ha_router_agent_port_bindings`
--

DROP TABLE IF EXISTS `ha_router_agent_port_bindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ha_router_agent_port_bindings` (
  `port_id` varchar(36) NOT NULL,
  `router_id` varchar(36) NOT NULL,
  `l3_agent_id` varchar(36) DEFAULT NULL,
  `state` enum('active','standby','unknown') DEFAULT 'standby',
  PRIMARY KEY (`port_id`),
  UNIQUE KEY `uniq_ha_router_agent_port_bindings0port_id0l3_agent_id` (`router_id`,`l3_agent_id`),
  KEY `l3_agent_id` (`l3_agent_id`),
  CONSTRAINT `ha_router_agent_port_bindings_ibfk_1` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ha_router_agent_port_bindings_ibfk_2` FOREIGN KEY (`router_id`) REFERENCES `routers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ha_router_agent_port_bindings_ibfk_3` FOREIGN KEY (`l3_agent_id`) REFERENCES `agents` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ha_router_agent_port_bindings`
--

LOCK TABLES `ha_router_agent_port_bindings` WRITE;
/*!40000 ALTER TABLE `ha_router_agent_port_bindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `ha_router_agent_port_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ha_router_networks`
--

DROP TABLE IF EXISTS `ha_router_networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ha_router_networks` (
  `project_id` varchar(255) NOT NULL,
  `network_id` varchar(36) NOT NULL,
  PRIMARY KEY (`project_id`,`network_id`),
  KEY `network_id` (`network_id`),
  CONSTRAINT `ha_router_networks_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ha_router_networks`
--

LOCK TABLES `ha_router_networks` WRITE;
/*!40000 ALTER TABLE `ha_router_networks` DISABLE KEYS */;
/*!40000 ALTER TABLE `ha_router_networks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ha_router_vrid_allocations`
--

DROP TABLE IF EXISTS `ha_router_vrid_allocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ha_router_vrid_allocations` (
  `network_id` varchar(36) NOT NULL,
  `vr_id` int(11) NOT NULL,
  PRIMARY KEY (`network_id`,`vr_id`),
  CONSTRAINT `ha_router_vrid_allocations_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ha_router_vrid_allocations`
--

LOCK TABLES `ha_router_vrid_allocations` WRITE;
/*!40000 ALTER TABLE `ha_router_vrid_allocations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ha_router_vrid_allocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `healthmonitors`
--

DROP TABLE IF EXISTS `healthmonitors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `healthmonitors` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `type` enum('PING','TCP','HTTP','HTTPS') NOT NULL,
  `delay` int(11) NOT NULL,
  `timeout` int(11) NOT NULL,
  `max_retries` int(11) NOT NULL,
  `http_method` varchar(16) DEFAULT NULL,
  `url_path` varchar(255) DEFAULT NULL,
  `expected_codes` varchar(64) DEFAULT NULL,
  `admin_state_up` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`admin_state_up` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `healthmonitors`
--

LOCK TABLES `healthmonitors` WRITE;
/*!40000 ALTER TABLE `healthmonitors` DISABLE KEYS */;
/*!40000 ALTER TABLE `healthmonitors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ikepolicies`
--

DROP TABLE IF EXISTS `ikepolicies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ikepolicies` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `auth_algorithm` enum('sha1') NOT NULL,
  `encryption_algorithm` enum('3des','aes-128','aes-256','aes-192') NOT NULL,
  `phase1_negotiation_mode` enum('main') NOT NULL,
  `lifetime_units` enum('seconds','kilobytes') NOT NULL,
  `lifetime_value` int(11) NOT NULL,
  `ike_version` enum('v1','v2') NOT NULL,
  `pfs` enum('group2','group5','group14') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ikepolicies`
--

LOCK TABLES `ikepolicies` WRITE;
/*!40000 ALTER TABLE `ikepolicies` DISABLE KEYS */;
/*!40000 ALTER TABLE `ikepolicies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipallocationpools`
--

DROP TABLE IF EXISTS `ipallocationpools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipallocationpools` (
  `id` varchar(36) NOT NULL,
  `subnet_id` varchar(36) DEFAULT NULL,
  `first_ip` varchar(64) NOT NULL,
  `last_ip` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `subnet_id` (`subnet_id`),
  CONSTRAINT `ipallocationpools_ibfk_1` FOREIGN KEY (`subnet_id`) REFERENCES `subnets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipallocationpools`
--

LOCK TABLES `ipallocationpools` WRITE;
/*!40000 ALTER TABLE `ipallocationpools` DISABLE KEYS */;
INSERT INTO `ipallocationpools` VALUES ('29a244a7-2b44-473c-a7f4-e091c3bcf2fe','52aed585-feeb-4790-a9d4-7640dfe54d52','2001:db8::1','2001:db8::1'),('4d4b1c30-c0ba-486d-9590-1ba4d8eb4875','52aed585-feeb-4790-a9d4-7640dfe54d52','2001:db8::3','2001:db8::ffff:ffff:ffff:ffff'),('aefca18a-0497-46f7-b459-2f5a3318c446','c89a62ce-6d89-4f16-8787-f78d42d9a7b8','fd7d:4ac9:b806::2','fd7d:4ac9:b806:0:ffff:ffff:ffff:ffff'),('b9f9e8bf-ba01-4174-864e-8b04eddccf6b','a9e97f57-f9fc-49be-8980-105b7bcf02f1','10.0.0.2','10.0.0.62'),('c1ab876e-e515-4895-befe-07ff6b33b346','87e7c8c2-99a3-4617-a793-88d9dbf9207c','172.24.4.2','172.24.4.254');
/*!40000 ALTER TABLE `ipallocationpools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipallocations`
--

DROP TABLE IF EXISTS `ipallocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipallocations` (
  `port_id` varchar(36) DEFAULT NULL,
  `ip_address` varchar(64) NOT NULL,
  `subnet_id` varchar(36) NOT NULL,
  `network_id` varchar(36) NOT NULL,
  PRIMARY KEY (`ip_address`,`subnet_id`,`network_id`),
  KEY `network_id` (`network_id`),
  KEY `port_id` (`port_id`),
  KEY `subnet_id` (`subnet_id`),
  CONSTRAINT `ipallocations_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipallocations_ibfk_2` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ipallocations_ibfk_3` FOREIGN KEY (`subnet_id`) REFERENCES `subnets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipallocations`
--

LOCK TABLES `ipallocations` WRITE;
/*!40000 ALTER TABLE `ipallocations` DISABLE KEYS */;
INSERT INTO `ipallocations` VALUES ('4fc10d04-40d2-4f22-8376-d5bfa0819d6a','172.24.4.16','87e7c8c2-99a3-4617-a793-88d9dbf9207c','f0718f76-f4a7-4549-b54b-5d1826daf9e4'),('4fc10d04-40d2-4f22-8376-d5bfa0819d6a','2001:db8::1','52aed585-feeb-4790-a9d4-7640dfe54d52','f0718f76-f4a7-4549-b54b-5d1826daf9e4'),('b96a0937-dd5e-4128-9724-894049ccc75e','10.0.0.1','a9e97f57-f9fc-49be-8980-105b7bcf02f1','e056503d-0d93-44a0-a9d5-d8540b347d8f'),('dcaba317-892b-4153-87ff-c1cf6aa263dc','10.0.0.2','a9e97f57-f9fc-49be-8980-105b7bcf02f1','e056503d-0d93-44a0-a9d5-d8540b347d8f'),('dcaba317-892b-4153-87ff-c1cf6aa263dc','fd7d:4ac9:b806:0:f816:3eff:fe58:8ae','c89a62ce-6d89-4f16-8787-f78d42d9a7b8','e056503d-0d93-44a0-a9d5-d8540b347d8f'),('ddf6870b-c46d-44a3-acf4-945d913e93db','fd7d:4ac9:b806::1','c89a62ce-6d89-4f16-8787-f78d42d9a7b8','e056503d-0d93-44a0-a9d5-d8540b347d8f');
/*!40000 ALTER TABLE `ipallocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipamallocationpools`
--

DROP TABLE IF EXISTS `ipamallocationpools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipamallocationpools` (
  `id` varchar(36) NOT NULL,
  `ipam_subnet_id` varchar(36) NOT NULL,
  `first_ip` varchar(64) NOT NULL,
  `last_ip` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ipam_subnet_id` (`ipam_subnet_id`),
  CONSTRAINT `ipamallocationpools_ibfk_1` FOREIGN KEY (`ipam_subnet_id`) REFERENCES `ipamsubnets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipamallocationpools`
--

LOCK TABLES `ipamallocationpools` WRITE;
/*!40000 ALTER TABLE `ipamallocationpools` DISABLE KEYS */;
INSERT INTO `ipamallocationpools` VALUES ('095e2d53-3f17-49c8-b582-5263bb14367f','7b658dfd-694f-4e1e-8a60-6ea075bf52aa','2001:db8::1','2001:db8::1'),('0e28460b-8596-4c51-b869-8e67c03fed04','96831317-65ed-4fc0-9cd4-39f43d2b2d30','fd7d:4ac9:b806::2','fd7d:4ac9:b806:0:ffff:ffff:ffff:ffff'),('604fd055-24c5-4b7a-b031-21696c58c581','7b658dfd-694f-4e1e-8a60-6ea075bf52aa','2001:db8::3','2001:db8::ffff:ffff:ffff:ffff'),('683f7e6d-80b3-43cd-a0dc-77fd6f6d4404','eec025f2-3f99-4369-87b2-8f446e1915d8','172.24.4.2','172.24.4.254'),('c3139b12-443d-496e-adc3-490e471e9c8e','b3de8759-4635-4482-b483-db1b9212487a','10.0.0.2','10.0.0.62');
/*!40000 ALTER TABLE `ipamallocationpools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipamallocations`
--

DROP TABLE IF EXISTS `ipamallocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipamallocations` (
  `ip_address` varchar(64) NOT NULL,
  `status` varchar(36) DEFAULT NULL,
  `ipam_subnet_id` varchar(36) NOT NULL,
  PRIMARY KEY (`ip_address`,`ipam_subnet_id`),
  KEY `ipam_subnet_id` (`ipam_subnet_id`),
  CONSTRAINT `ipamallocations_ibfk_1` FOREIGN KEY (`ipam_subnet_id`) REFERENCES `ipamsubnets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipamallocations`
--

LOCK TABLES `ipamallocations` WRITE;
/*!40000 ALTER TABLE `ipamallocations` DISABLE KEYS */;
INSERT INTO `ipamallocations` VALUES ('10.0.0.1','ALLOCATED','b3de8759-4635-4482-b483-db1b9212487a'),('10.0.0.2','ALLOCATED','b3de8759-4635-4482-b483-db1b9212487a'),('172.24.4.16','ALLOCATED','eec025f2-3f99-4369-87b2-8f446e1915d8'),('2001:db8::1','ALLOCATED','7b658dfd-694f-4e1e-8a60-6ea075bf52aa'),('fd7d:4ac9:b806:0:f816:3eff:fe58:8ae','ALLOCATED','96831317-65ed-4fc0-9cd4-39f43d2b2d30'),('fd7d:4ac9:b806::1','ALLOCATED','96831317-65ed-4fc0-9cd4-39f43d2b2d30');
/*!40000 ALTER TABLE `ipamallocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipamsubnets`
--

DROP TABLE IF EXISTS `ipamsubnets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipamsubnets` (
  `id` varchar(36) NOT NULL,
  `neutron_subnet_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipamsubnets`
--

LOCK TABLES `ipamsubnets` WRITE;
/*!40000 ALTER TABLE `ipamsubnets` DISABLE KEYS */;
INSERT INTO `ipamsubnets` VALUES ('7b658dfd-694f-4e1e-8a60-6ea075bf52aa','52aed585-feeb-4790-a9d4-7640dfe54d52'),('96831317-65ed-4fc0-9cd4-39f43d2b2d30','c89a62ce-6d89-4f16-8787-f78d42d9a7b8'),('b3de8759-4635-4482-b483-db1b9212487a','a9e97f57-f9fc-49be-8980-105b7bcf02f1'),('eec025f2-3f99-4369-87b2-8f446e1915d8','87e7c8c2-99a3-4617-a793-88d9dbf9207c');
/*!40000 ALTER TABLE `ipamsubnets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipsec_site_connections`
--

DROP TABLE IF EXISTS `ipsec_site_connections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipsec_site_connections` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `peer_address` varchar(255) NOT NULL,
  `peer_id` varchar(255) NOT NULL,
  `route_mode` varchar(8) NOT NULL,
  `mtu` int(11) NOT NULL,
  `initiator` enum('bi-directional','response-only') NOT NULL,
  `auth_mode` varchar(16) NOT NULL,
  `psk` varchar(255) NOT NULL,
  `dpd_action` enum('hold','clear','restart','disabled','restart-by-peer') NOT NULL,
  `dpd_interval` int(11) NOT NULL,
  `dpd_timeout` int(11) NOT NULL,
  `status` varchar(16) NOT NULL,
  `admin_state_up` tinyint(1) NOT NULL,
  `vpnservice_id` varchar(36) NOT NULL,
  `ipsecpolicy_id` varchar(36) NOT NULL,
  `ikepolicy_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `vpnservice_id` (`vpnservice_id`),
  KEY `ipsecpolicy_id` (`ipsecpolicy_id`),
  KEY `ikepolicy_id` (`ikepolicy_id`),
  CONSTRAINT `ipsec_site_connections_ibfk_1` FOREIGN KEY (`vpnservice_id`) REFERENCES `vpnservices` (`id`),
  CONSTRAINT `ipsec_site_connections_ibfk_2` FOREIGN KEY (`ipsecpolicy_id`) REFERENCES `ipsecpolicies` (`id`),
  CONSTRAINT `ipsec_site_connections_ibfk_3` FOREIGN KEY (`ikepolicy_id`) REFERENCES `ikepolicies` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`admin_state_up` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipsec_site_connections`
--

LOCK TABLES `ipsec_site_connections` WRITE;
/*!40000 ALTER TABLE `ipsec_site_connections` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipsec_site_connections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipsecpeercidrs`
--

DROP TABLE IF EXISTS `ipsecpeercidrs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipsecpeercidrs` (
  `cidr` varchar(32) NOT NULL,
  `ipsec_site_connection_id` varchar(36) NOT NULL,
  PRIMARY KEY (`cidr`,`ipsec_site_connection_id`),
  KEY `ipsec_site_connection_id` (`ipsec_site_connection_id`),
  CONSTRAINT `ipsecpeercidrs_ibfk_1` FOREIGN KEY (`ipsec_site_connection_id`) REFERENCES `ipsec_site_connections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipsecpeercidrs`
--

LOCK TABLES `ipsecpeercidrs` WRITE;
/*!40000 ALTER TABLE `ipsecpeercidrs` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipsecpeercidrs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ipsecpolicies`
--

DROP TABLE IF EXISTS `ipsecpolicies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ipsecpolicies` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `transform_protocol` enum('esp','ah','ah-esp') NOT NULL,
  `auth_algorithm` enum('sha1') NOT NULL,
  `encryption_algorithm` enum('3des','aes-128','aes-256','aes-192') NOT NULL,
  `encapsulation_mode` enum('tunnel','transport') NOT NULL,
  `lifetime_units` enum('seconds','kilobytes') NOT NULL,
  `lifetime_value` int(11) NOT NULL,
  `pfs` enum('group2','group5','group14') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ipsecpolicies`
--

LOCK TABLES `ipsecpolicies` WRITE;
/*!40000 ALTER TABLE `ipsecpolicies` DISABLE KEYS */;
/*!40000 ALTER TABLE `ipsecpolicies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `logs`
--

DROP TABLE IF EXISTS `logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logs` (
  `project_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `standard_attr_id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `resource_type` varchar(36) NOT NULL,
  `resource_id` varchar(36) DEFAULT NULL,
  `target_id` varchar(36) DEFAULT NULL,
  `event` varchar(255) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `standard_attr_id` (`standard_attr_id`),
  KEY `ix_logs_project_id` (`project_id`),
  KEY `ix_logs_target_id` (`target_id`),
  KEY `ix_logs_resource_id` (`resource_id`),
  CONSTRAINT `logs_ibfk_1` FOREIGN KEY (`standard_attr_id`) REFERENCES `standardattributes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`enabled` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `logs`
--

LOCK TABLES `logs` WRITE;
/*!40000 ALTER TABLE `logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `logs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lsn`
--

DROP TABLE IF EXISTS `lsn`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lsn` (
  `net_id` varchar(36) NOT NULL,
  `lsn_id` varchar(36) NOT NULL,
  PRIMARY KEY (`lsn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lsn`
--

LOCK TABLES `lsn` WRITE;
/*!40000 ALTER TABLE `lsn` DISABLE KEYS */;
/*!40000 ALTER TABLE `lsn` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lsn_port`
--

DROP TABLE IF EXISTS `lsn_port`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lsn_port` (
  `lsn_port_id` varchar(36) NOT NULL,
  `lsn_id` varchar(36) NOT NULL,
  `sub_id` varchar(36) NOT NULL,
  `mac_addr` varchar(32) NOT NULL,
  PRIMARY KEY (`lsn_port_id`),
  UNIQUE KEY `sub_id` (`sub_id`),
  UNIQUE KEY `mac_addr` (`mac_addr`),
  KEY `lsn_id` (`lsn_id`),
  CONSTRAINT `lsn_port_ibfk_1` FOREIGN KEY (`lsn_id`) REFERENCES `lsn` (`lsn_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lsn_port`
--

LOCK TABLES `lsn_port` WRITE;
/*!40000 ALTER TABLE `lsn_port` DISABLE KEYS */;
/*!40000 ALTER TABLE `lsn_port` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maclearningstates`
--

DROP TABLE IF EXISTS `maclearningstates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `maclearningstates` (
  `port_id` varchar(36) NOT NULL,
  `mac_learning_enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`port_id`),
  CONSTRAINT `maclearningstates_ibfk_1` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`mac_learning_enabled` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maclearningstates`
--

LOCK TABLES `maclearningstates` WRITE;
/*!40000 ALTER TABLE `maclearningstates` DISABLE KEYS */;
/*!40000 ALTER TABLE `maclearningstates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `members` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `status` varchar(16) NOT NULL,
  `status_description` varchar(255) DEFAULT NULL,
  `pool_id` varchar(36) NOT NULL,
  `address` varchar(64) NOT NULL,
  `protocol_port` int(11) NOT NULL,
  `weight` int(11) NOT NULL,
  `admin_state_up` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_member0pool_id0address0port` (`pool_id`,`address`,`protocol_port`),
  CONSTRAINT `members_ibfk_1` FOREIGN KEY (`pool_id`) REFERENCES `pools` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`admin_state_up` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `members`
--

LOCK TABLES `members` WRITE;
/*!40000 ALTER TABLE `members` DISABLE KEYS */;
/*!40000 ALTER TABLE `members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meteringlabelrules`
--

DROP TABLE IF EXISTS `meteringlabelrules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meteringlabelrules` (
  `id` varchar(36) NOT NULL,
  `direction` enum('ingress','egress') DEFAULT NULL,
  `remote_ip_prefix` varchar(64) DEFAULT NULL,
  `metering_label_id` varchar(36) NOT NULL,
  `excluded` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `metering_label_id` (`metering_label_id`),
  CONSTRAINT `meteringlabelrules_ibfk_1` FOREIGN KEY (`metering_label_id`) REFERENCES `meteringlabels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`excluded` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meteringlabelrules`
--

LOCK TABLES `meteringlabelrules` WRITE;
/*!40000 ALTER TABLE `meteringlabelrules` DISABLE KEYS */;
/*!40000 ALTER TABLE `meteringlabelrules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `meteringlabels`
--

DROP TABLE IF EXISTS `meteringlabels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `meteringlabels` (
  `project_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `shared` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `ix_meteringlabels_project_id` (`project_id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`shared` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meteringlabels`
--

LOCK TABLES `meteringlabels` WRITE;
/*!40000 ALTER TABLE `meteringlabels` DISABLE KEYS */;
/*!40000 ALTER TABLE `meteringlabels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml2_brocadenetworks`
--

DROP TABLE IF EXISTS `ml2_brocadenetworks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml2_brocadenetworks` (
  `id` varchar(36) NOT NULL,
  `vlan` varchar(10) DEFAULT NULL,
  `segment_id` varchar(36) DEFAULT NULL,
  `network_type` varchar(10) DEFAULT NULL,
  `tenant_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_ml2_brocadenetworks_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml2_brocadenetworks`
--

LOCK TABLES `ml2_brocadenetworks` WRITE;
/*!40000 ALTER TABLE `ml2_brocadenetworks` DISABLE KEYS */;
/*!40000 ALTER TABLE `ml2_brocadenetworks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml2_brocadeports`
--

DROP TABLE IF EXISTS `ml2_brocadeports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml2_brocadeports` (
  `id` varchar(36) NOT NULL,
  `network_id` varchar(36) NOT NULL,
  `admin_state_up` tinyint(1) NOT NULL,
  `physical_interface` varchar(36) DEFAULT NULL,
  `vlan_id` varchar(36) DEFAULT NULL,
  `tenant_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `network_id` (`network_id`),
  KEY `ix_ml2_brocadeports_tenant_id` (`tenant_id`),
  CONSTRAINT `ml2_brocadeports_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `ml2_brocadenetworks` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`admin_state_up` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml2_brocadeports`
--

LOCK TABLES `ml2_brocadeports` WRITE;
/*!40000 ALTER TABLE `ml2_brocadeports` DISABLE KEYS */;
/*!40000 ALTER TABLE `ml2_brocadeports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml2_distributed_port_bindings`
--

DROP TABLE IF EXISTS `ml2_distributed_port_bindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml2_distributed_port_bindings` (
  `port_id` varchar(36) NOT NULL,
  `host` varchar(255) NOT NULL,
  `router_id` varchar(36) DEFAULT NULL,
  `vif_type` varchar(64) NOT NULL,
  `vif_details` varchar(4095) NOT NULL DEFAULT '',
  `vnic_type` varchar(64) NOT NULL DEFAULT 'normal',
  `profile` varchar(4095) NOT NULL DEFAULT '',
  `status` varchar(16) NOT NULL,
  PRIMARY KEY (`port_id`,`host`),
  CONSTRAINT `ml2_distributed_port_bindings_ibfk_1` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml2_distributed_port_bindings`
--

LOCK TABLES `ml2_distributed_port_bindings` WRITE;
/*!40000 ALTER TABLE `ml2_distributed_port_bindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `ml2_distributed_port_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml2_flat_allocations`
--

DROP TABLE IF EXISTS `ml2_flat_allocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml2_flat_allocations` (
  `physical_network` varchar(64) NOT NULL,
  PRIMARY KEY (`physical_network`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml2_flat_allocations`
--

LOCK TABLES `ml2_flat_allocations` WRITE;
/*!40000 ALTER TABLE `ml2_flat_allocations` DISABLE KEYS */;
INSERT INTO `ml2_flat_allocations` VALUES ('public');
/*!40000 ALTER TABLE `ml2_flat_allocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml2_geneve_allocations`
--

DROP TABLE IF EXISTS `ml2_geneve_allocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml2_geneve_allocations` (
  `geneve_vni` int(11) NOT NULL,
  `allocated` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`geneve_vni`),
  KEY `ix_ml2_geneve_allocations_allocated` (`allocated`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`allocated` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml2_geneve_allocations`
--

LOCK TABLES `ml2_geneve_allocations` WRITE;
/*!40000 ALTER TABLE `ml2_geneve_allocations` DISABLE KEYS */;
INSERT INTO `ml2_geneve_allocations` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0),(8,0),(9,0),(10,0),(11,0),(12,0),(13,0),(14,0),(15,0),(16,0),(17,0),(18,0),(19,0),(20,0),(21,0),(22,0),(23,0),(24,0),(25,0),(26,0),(27,0),(28,0),(29,0),(30,0),(31,0),(32,0),(33,0),(34,0),(35,0),(36,0),(37,0),(38,0),(39,0),(40,0),(41,0),(42,0),(43,0),(44,0),(45,0),(46,0),(47,0),(48,0),(49,0),(50,0),(51,0),(52,0),(53,0),(54,0),(55,0),(56,0),(57,0),(58,0),(59,0),(60,0),(61,0),(62,0),(63,0),(64,0),(65,0),(66,0),(67,0),(68,0),(69,0),(70,0),(71,0),(72,0),(73,0),(74,0),(75,0),(76,0),(77,0),(78,0),(79,0),(80,0),(81,0),(82,0),(83,0),(84,0),(85,0),(86,0),(87,0),(88,0),(89,0),(90,0),(91,0),(92,0),(93,0),(94,0),(95,0),(96,0),(97,0),(98,0),(99,0),(100,0),(101,0),(102,0),(103,0),(104,0),(105,0),(106,0),(107,0),(108,0),(109,0),(110,0),(111,0),(112,0),(113,0),(114,0),(115,0),(116,0),(117,0),(118,0),(119,0),(120,0),(121,0),(122,0),(123,0),(124,0),(125,0),(126,0),(127,0),(128,0),(129,0),(130,0),(131,0),(132,0),(133,0),(134,0),(135,0),(136,0),(137,0),(138,0),(139,0),(140,0),(141,0),(142,0),(143,0),(144,0),(145,0),(146,0),(147,0),(148,0),(149,0),(150,0),(151,0),(152,0),(153,0),(154,0),(155,0),(156,0),(157,0),(158,0),(159,0),(160,0),(161,0),(162,0),(163,0),(164,0),(165,0),(166,0),(167,0),(168,0),(169,0),(170,0),(171,0),(172,0),(173,0),(174,0),(175,0),(176,0),(177,0),(178,0),(179,0),(180,0),(181,0),(182,0),(183,0),(184,0),(185,0),(186,0),(187,0),(188,0),(189,0),(190,0),(191,0),(192,0),(193,0),(194,0),(195,0),(196,0),(197,0),(198,0),(199,0),(200,0),(201,0),(202,0),(203,0),(204,0),(205,0),(206,0),(207,0),(208,0),(209,0),(210,0),(211,0),(212,0),(213,0),(214,0),(215,0),(216,0),(217,0),(218,0),(219,0),(220,0),(221,0),(222,0),(223,0),(224,0),(225,0),(226,0),(227,0),(228,0),(229,0),(230,0),(231,0),(232,0),(233,0),(234,0),(235,0),(236,0),(237,0),(238,0),(239,0),(240,0),(241,0),(242,0),(243,0),(244,0),(245,0),(246,0),(247,0),(248,0),(249,0),(250,0),(251,0),(252,0),(253,0),(254,0),(255,0),(256,0),(257,0),(258,0),(259,0),(260,0),(261,0),(262,0),(263,0),(264,0),(265,0),(266,0),(267,0),(268,0),(269,0),(270,0),(271,0),(272,0),(273,0),(274,0),(275,0),(276,0),(277,0),(278,0),(279,0),(280,0),(281,0),(282,0),(283,0),(284,0),(285,0),(286,0),(287,0),(288,0),(289,0),(290,0),(291,0),(292,0),(293,0),(294,0),(295,0),(296,0),(297,0),(298,0),(299,0),(300,0),(301,0),(302,0),(303,0),(304,0),(305,0),(306,0),(307,0),(308,0),(309,0),(310,0),(311,0),(312,0),(313,0),(314,0),(315,0),(316,0),(317,0),(318,0),(319,0),(320,0),(321,0),(322,0),(323,0),(324,0),(325,0),(326,0),(327,0),(328,0),(329,0),(330,0),(331,0),(332,0),(333,0),(334,0),(335,0),(336,0),(337,0),(338,0),(339,0),(340,0),(341,0),(342,0),(343,0),(344,0),(345,0),(346,0),(347,0),(348,0),(349,0),(350,0),(351,0),(352,0),(353,0),(354,0),(355,0),(356,0),(357,0),(358,0),(359,0),(360,0),(361,0),(362,0),(363,0),(364,0),(365,0),(366,0),(367,0),(368,0),(369,0),(370,0),(371,0),(372,0),(373,0),(374,0),(375,0),(376,0),(377,0),(378,0),(379,0),(380,0),(381,0),(382,0),(383,0),(384,0),(385,0),(386,0),(387,0),(388,0),(389,0),(390,0),(391,0),(392,0),(393,0),(394,0),(395,0),(396,0),(397,0),(398,0),(399,0),(400,0),(401,0),(402,0),(403,0),(404,0),(405,0),(406,0),(407,0),(408,0),(409,0),(410,0),(411,0),(412,0),(413,0),(414,0),(415,0),(416,0),(417,0),(418,0),(419,0),(420,0),(421,0),(422,0),(423,0),(424,0),(425,0),(426,0),(427,0),(428,0),(429,0),(430,0),(431,0),(432,0),(433,0),(434,0),(435,0),(436,0),(437,0),(438,0),(439,0),(440,0),(441,0),(442,0),(443,0),(444,0),(445,0),(446,0),(447,0),(448,0),(449,0),(450,0),(451,0),(452,0),(453,0),(454,0),(455,0),(456,0),(457,0),(458,0),(459,0),(460,0),(461,0),(462,0),(463,0),(464,0),(465,0),(466,0),(467,0),(468,0),(469,0),(470,0),(471,0),(472,0),(473,0),(474,0),(475,0),(476,0),(477,0),(478,0),(479,0),(480,0),(481,0),(482,0),(483,0),(484,0),(485,0),(486,0),(487,0),(488,0),(489,0),(490,0),(491,0),(492,0),(493,0),(494,0),(495,0),(496,0),(497,0),(498,0),(499,0),(500,0),(501,0),(502,0),(503,0),(504,0),(505,0),(506,0),(507,0),(508,0),(509,0),(510,0),(511,0),(512,0),(513,0),(514,0),(515,0),(516,0),(517,0),(518,0),(519,0),(520,0),(521,0),(522,0),(523,0),(524,0),(525,0),(526,0),(527,0),(528,0),(529,0),(530,0),(531,0),(532,0),(533,0),(534,0),(535,0),(536,0),(537,0),(538,0),(539,0),(540,0),(541,0),(542,0),(543,0),(544,0),(545,0),(546,0),(547,0),(548,0),(549,0),(550,0),(551,0),(552,0),(553,0),(554,0),(555,0),(556,0),(557,0),(558,0),(559,0),(560,0),(561,0),(562,0),(563,0),(564,0),(565,0),(566,0),(567,0),(568,0),(569,0),(570,0),(571,0),(572,0),(573,0),(574,0),(575,0),(576,0),(577,0),(578,0),(579,0),(580,0),(581,0),(582,0),(583,0),(584,0),(585,0),(586,0),(587,0),(588,0),(589,0),(590,0),(591,0),(592,0),(593,0),(594,0),(595,0),(596,0),(597,0),(598,0),(599,0),(600,0),(601,0),(602,0),(603,0),(604,0),(605,0),(606,0),(607,0),(608,0),(609,0),(610,0),(611,0),(612,0),(613,0),(614,0),(615,0),(616,0),(617,0),(618,0),(619,0),(620,0),(621,0),(622,0),(623,0),(624,0),(625,0),(626,0),(627,0),(628,0),(629,0),(630,0),(631,0),(632,0),(633,0),(634,0),(635,0),(636,0),(637,0),(638,0),(639,0),(640,0),(641,0),(642,0),(643,0),(644,0),(645,0),(646,0),(647,0),(648,0),(649,0),(650,0),(651,0),(652,0),(653,0),(654,0),(655,0),(656,0),(657,0),(658,0),(659,0),(660,0),(661,0),(662,0),(663,0),(664,0),(665,0),(666,0),(667,0),(668,0),(669,0),(670,0),(671,0),(672,0),(673,0),(674,0),(675,0),(676,0),(677,0),(678,0),(679,0),(680,0),(681,0),(682,0),(683,0),(684,0),(685,0),(686,0),(687,0),(688,0),(689,0),(690,0),(691,0),(692,0),(693,0),(694,0),(695,0),(696,0),(697,0),(698,0),(699,0),(700,0),(701,0),(702,0),(703,0),(704,0),(705,0),(706,0),(707,0),(708,0),(709,0),(710,0),(711,0),(712,0),(713,0),(714,0),(715,0),(716,0),(717,0),(718,0),(719,0),(720,0),(721,0),(722,0),(723,0),(724,0),(725,0),(726,0),(727,0),(728,0),(729,0),(730,0),(731,0),(732,0),(733,0),(734,0),(735,0),(736,0),(737,0),(738,0),(739,0),(740,0),(741,0),(742,0),(743,0),(744,0),(745,0),(746,0),(747,0),(748,0),(749,0),(750,0),(751,0),(752,0),(753,0),(754,0),(755,0),(756,0),(757,0),(758,0),(759,0),(760,0),(761,0),(762,0),(763,0),(764,0),(765,0),(766,0),(767,0),(768,0),(769,0),(770,0),(771,0),(772,0),(773,0),(774,0),(775,0),(776,0),(777,0),(778,0),(779,0),(780,0),(781,0),(782,0),(783,0),(784,0),(785,0),(786,0),(787,0),(788,0),(789,0),(790,0),(791,0),(792,0),(793,0),(794,0),(795,0),(796,0),(797,0),(798,0),(799,0),(800,0),(801,0),(802,0),(803,0),(804,0),(805,0),(806,0),(807,0),(808,0),(809,0),(810,0),(811,0),(812,0),(813,0),(814,0),(815,0),(816,0),(817,0),(818,0),(819,0),(820,0),(821,0),(822,0),(823,0),(824,0),(825,0),(826,0),(827,0),(828,0),(829,0),(830,0),(831,0),(832,0),(833,0),(834,0),(835,0),(836,0),(837,0),(838,0),(839,0),(840,0),(841,0),(842,0),(843,0),(844,0),(845,0),(846,0),(847,0),(848,0),(849,0),(850,0),(851,0),(852,0),(853,0),(854,0),(855,0),(856,0),(857,0),(858,0),(859,0),(860,0),(861,0),(862,0),(863,0),(864,0),(865,0),(866,0),(867,0),(868,0),(869,0),(870,0),(871,0),(872,0),(873,0),(874,0),(875,0),(876,0),(877,0),(878,0),(879,0),(880,0),(881,0),(882,0),(883,0),(884,0),(885,0),(886,0),(887,0),(888,0),(889,0),(890,0),(891,0),(892,0),(893,0),(894,0),(895,0),(896,0),(897,0),(898,0),(899,0),(900,0),(901,0),(902,0),(903,0),(904,0),(905,0),(906,0),(907,0),(908,0),(909,0),(910,0),(911,0),(912,0),(913,0),(914,0),(915,0),(916,0),(917,0),(918,0),(919,0),(920,0),(921,0),(922,0),(923,0),(924,0),(925,0),(926,0),(927,0),(928,0),(929,0),(930,0),(931,0),(932,0),(933,0),(934,0),(935,0),(936,0),(937,0),(938,0),(939,0),(940,0),(941,0),(942,0),(943,0),(944,0),(945,0),(946,0),(947,0),(948,0),(949,0),(950,0),(951,0),(952,0),(953,0),(954,0),(955,0),(956,0),(957,0),(958,0),(959,0),(960,0),(961,0),(962,0),(963,0),(964,0),(965,0),(966,0),(967,0),(968,0),(969,0),(970,0),(971,0),(972,0),(973,0),(974,0),(975,0),(976,0),(977,0),(978,0),(979,0),(980,0),(981,0),(982,0),(983,0),(984,0),(985,0),(986,0),(987,0),(988,0),(989,0),(990,0),(991,0),(992,0),(993,0),(994,0),(995,0),(996,0),(997,0),(998,0),(999,0),(1000,0);
/*!40000 ALTER TABLE `ml2_geneve_allocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml2_geneve_endpoints`
--

DROP TABLE IF EXISTS `ml2_geneve_endpoints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml2_geneve_endpoints` (
  `ip_address` varchar(64) NOT NULL,
  `host` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ip_address`),
  UNIQUE KEY `unique_ml2_geneve_endpoints0host` (`host`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml2_geneve_endpoints`
--

LOCK TABLES `ml2_geneve_endpoints` WRITE;
/*!40000 ALTER TABLE `ml2_geneve_endpoints` DISABLE KEYS */;
/*!40000 ALTER TABLE `ml2_geneve_endpoints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml2_gre_allocations`
--

DROP TABLE IF EXISTS `ml2_gre_allocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml2_gre_allocations` (
  `gre_id` int(11) NOT NULL,
  `allocated` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`gre_id`),
  KEY `ix_ml2_gre_allocations_allocated` (`allocated`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`allocated` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml2_gre_allocations`
--

LOCK TABLES `ml2_gre_allocations` WRITE;
/*!40000 ALTER TABLE `ml2_gre_allocations` DISABLE KEYS */;
INSERT INTO `ml2_gre_allocations` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0),(8,0),(9,0),(10,0),(11,0),(12,0),(13,0),(14,0),(15,0),(16,0),(17,0),(18,0),(19,0),(20,0),(21,0),(22,0),(23,0),(24,0),(25,0),(26,0),(27,0),(28,0),(29,0),(30,0),(31,0),(32,0),(33,0),(34,0),(35,0),(36,0),(37,0),(38,0),(39,0),(40,0),(41,0),(42,0),(43,0),(44,0),(45,0),(46,0),(47,0),(48,0),(49,0),(50,0),(51,0),(52,0),(53,0),(54,0),(55,0),(56,0),(57,0),(58,0),(59,0),(60,0),(61,0),(62,0),(63,0),(64,0),(65,0),(66,0),(67,0),(68,0),(69,0),(70,0),(71,0),(72,0),(73,0),(74,0),(75,0),(76,0),(77,0),(78,0),(79,0),(80,0),(81,0),(82,0),(83,0),(84,0),(85,0),(86,0),(87,0),(88,0),(89,0),(90,0),(91,0),(92,0),(93,0),(94,0),(95,0),(96,0),(97,0),(98,0),(99,0),(100,0),(101,0),(102,0),(103,0),(104,0),(105,0),(106,0),(107,0),(108,0),(109,0),(110,0),(111,0),(112,0),(113,0),(114,0),(115,0),(116,0),(117,0),(118,0),(119,0),(120,0),(121,0),(122,0),(123,0),(124,0),(125,0),(126,0),(127,0),(128,0),(129,0),(130,0),(131,0),(132,0),(133,0),(134,0),(135,0),(136,0),(137,0),(138,0),(139,0),(140,0),(141,0),(142,0),(143,0),(144,0),(145,0),(146,0),(147,0),(148,0),(149,0),(150,0),(151,0),(152,0),(153,0),(154,0),(155,0),(156,0),(157,0),(158,0),(159,0),(160,0),(161,0),(162,0),(163,0),(164,0),(165,0),(166,0),(167,0),(168,0),(169,0),(170,0),(171,0),(172,0),(173,0),(174,0),(175,0),(176,0),(177,0),(178,0),(179,0),(180,0),(181,0),(182,0),(183,0),(184,0),(185,0),(186,0),(187,0),(188,0),(189,0),(190,0),(191,0),(192,0),(193,0),(194,0),(195,0),(196,0),(197,0),(198,0),(199,0),(200,0),(201,0),(202,0),(203,0),(204,0),(205,0),(206,0),(207,0),(208,0),(209,0),(210,0),(211,0),(212,0),(213,0),(214,0),(215,0),(216,0),(217,0),(218,0),(219,0),(220,0),(221,0),(222,0),(223,0),(224,0),(225,0),(226,0),(227,0),(228,0),(229,0),(230,0),(231,0),(232,0),(233,0),(234,0),(235,0),(236,0),(237,0),(238,0),(239,0),(240,0),(241,0),(242,0),(243,0),(244,0),(245,0),(246,0),(247,0),(248,0),(249,0),(250,0),(251,0),(252,0),(253,0),(254,0),(255,0),(256,0),(257,0),(258,0),(259,0),(260,0),(261,0),(262,0),(263,0),(264,0),(265,0),(266,0),(267,0),(268,0),(269,0),(270,0),(271,0),(272,0),(273,0),(274,0),(275,0),(276,0),(277,0),(278,0),(279,0),(280,0),(281,0),(282,0),(283,0),(284,0),(285,0),(286,0),(287,0),(288,0),(289,0),(290,0),(291,0),(292,0),(293,0),(294,0),(295,0),(296,0),(297,0),(298,0),(299,0),(300,0),(301,0),(302,0),(303,0),(304,0),(305,0),(306,0),(307,0),(308,0),(309,0),(310,0),(311,0),(312,0),(313,0),(314,0),(315,0),(316,0),(317,0),(318,0),(319,0),(320,0),(321,0),(322,0),(323,0),(324,0),(325,0),(326,0),(327,0),(328,0),(329,0),(330,0),(331,0),(332,0),(333,0),(334,0),(335,0),(336,0),(337,0),(338,0),(339,0),(340,0),(341,0),(342,0),(343,0),(344,0),(345,0),(346,0),(347,0),(348,0),(349,0),(350,0),(351,0),(352,0),(353,0),(354,0),(355,0),(356,0),(357,0),(358,0),(359,0),(360,0),(361,0),(362,0),(363,0),(364,0),(365,0),(366,0),(367,0),(368,0),(369,0),(370,0),(371,0),(372,0),(373,0),(374,0),(375,0),(376,0),(377,0),(378,0),(379,0),(380,0),(381,0),(382,0),(383,0),(384,0),(385,0),(386,0),(387,0),(388,0),(389,0),(390,0),(391,0),(392,0),(393,0),(394,0),(395,0),(396,0),(397,0),(398,0),(399,0),(400,0),(401,0),(402,0),(403,0),(404,0),(405,0),(406,0),(407,0),(408,0),(409,0),(410,0),(411,0),(412,0),(413,0),(414,0),(415,0),(416,0),(417,0),(418,0),(419,0),(420,0),(421,0),(422,0),(423,0),(424,0),(425,0),(426,0),(427,0),(428,0),(429,0),(430,0),(431,0),(432,0),(433,0),(434,0),(435,0),(436,0),(437,0),(438,0),(439,0),(440,0),(441,0),(442,0),(443,0),(444,0),(445,0),(446,0),(447,0),(448,0),(449,0),(450,0),(451,0),(452,0),(453,0),(454,0),(455,0),(456,0),(457,0),(458,0),(459,0),(460,0),(461,0),(462,0),(463,0),(464,0),(465,0),(466,0),(467,0),(468,0),(469,0),(470,0),(471,0),(472,0),(473,0),(474,0),(475,0),(476,0),(477,0),(478,0),(479,0),(480,0),(481,0),(482,0),(483,0),(484,0),(485,0),(486,0),(487,0),(488,0),(489,0),(490,0),(491,0),(492,0),(493,0),(494,0),(495,0),(496,0),(497,0),(498,0),(499,0),(500,0),(501,0),(502,0),(503,0),(504,0),(505,0),(506,0),(507,0),(508,0),(509,0),(510,0),(511,0),(512,0),(513,0),(514,0),(515,0),(516,0),(517,0),(518,0),(519,0),(520,0),(521,0),(522,0),(523,0),(524,0),(525,0),(526,0),(527,0),(528,0),(529,0),(530,0),(531,0),(532,0),(533,0),(534,0),(535,0),(536,0),(537,0),(538,0),(539,0),(540,0),(541,0),(542,0),(543,0),(544,0),(545,0),(546,0),(547,0),(548,0),(549,0),(550,0),(551,0),(552,0),(553,0),(554,0),(555,0),(556,0),(557,0),(558,0),(559,0),(560,0),(561,0),(562,0),(563,0),(564,0),(565,0),(566,0),(567,0),(568,0),(569,0),(570,0),(571,0),(572,0),(573,0),(574,0),(575,0),(576,0),(577,0),(578,0),(579,0),(580,0),(581,0),(582,0),(583,0),(584,0),(585,0),(586,0),(587,0),(588,0),(589,0),(590,0),(591,0),(592,0),(593,0),(594,0),(595,0),(596,0),(597,0),(598,0),(599,0),(600,0),(601,0),(602,0),(603,0),(604,0),(605,0),(606,0),(607,0),(608,0),(609,0),(610,0),(611,0),(612,0),(613,0),(614,0),(615,0),(616,0),(617,0),(618,0),(619,0),(620,0),(621,0),(622,0),(623,0),(624,0),(625,0),(626,0),(627,0),(628,0),(629,0),(630,0),(631,0),(632,0),(633,0),(634,0),(635,0),(636,0),(637,0),(638,0),(639,0),(640,0),(641,0),(642,0),(643,0),(644,0),(645,0),(646,0),(647,0),(648,0),(649,0),(650,0),(651,0),(652,0),(653,0),(654,0),(655,0),(656,0),(657,0),(658,0),(659,0),(660,0),(661,0),(662,0),(663,0),(664,0),(665,0),(666,0),(667,0),(668,0),(669,0),(670,0),(671,0),(672,0),(673,0),(674,0),(675,0),(676,0),(677,0),(678,0),(679,0),(680,0),(681,0),(682,0),(683,0),(684,0),(685,0),(686,0),(687,0),(688,0),(689,0),(690,0),(691,0),(692,0),(693,0),(694,0),(695,0),(696,0),(697,0),(698,0),(699,0),(700,0),(701,0),(702,0),(703,0),(704,0),(705,0),(706,0),(707,0),(708,0),(709,0),(710,0),(711,0),(712,0),(713,0),(714,0),(715,0),(716,0),(717,0),(718,0),(719,0),(720,0),(721,0),(722,0),(723,0),(724,0),(725,0),(726,0),(727,0),(728,0),(729,0),(730,0),(731,0),(732,0),(733,0),(734,0),(735,0),(736,0),(737,0),(738,0),(739,0),(740,0),(741,0),(742,0),(743,0),(744,0),(745,0),(746,0),(747,0),(748,0),(749,0),(750,0),(751,0),(752,0),(753,0),(754,0),(755,0),(756,0),(757,0),(758,0),(759,0),(760,0),(761,0),(762,0),(763,0),(764,0),(765,0),(766,0),(767,0),(768,0),(769,0),(770,0),(771,0),(772,0),(773,0),(774,0),(775,0),(776,0),(777,0),(778,0),(779,0),(780,0),(781,0),(782,0),(783,0),(784,0),(785,0),(786,0),(787,0),(788,0),(789,0),(790,0),(791,0),(792,0),(793,0),(794,0),(795,0),(796,0),(797,0),(798,0),(799,0),(800,0),(801,0),(802,0),(803,0),(804,0),(805,0),(806,0),(807,0),(808,0),(809,0),(810,0),(811,0),(812,0),(813,0),(814,0),(815,0),(816,0),(817,0),(818,0),(819,0),(820,0),(821,0),(822,0),(823,0),(824,0),(825,0),(826,0),(827,0),(828,0),(829,0),(830,0),(831,0),(832,0),(833,0),(834,0),(835,0),(836,0),(837,0),(838,0),(839,0),(840,0),(841,0),(842,0),(843,0),(844,0),(845,0),(846,0),(847,0),(848,0),(849,0),(850,0),(851,0),(852,0),(853,0),(854,0),(855,0),(856,0),(857,0),(858,0),(859,0),(860,0),(861,0),(862,0),(863,0),(864,0),(865,0),(866,0),(867,0),(868,0),(869,0),(870,0),(871,0),(872,0),(873,0),(874,0),(875,0),(876,0),(877,0),(878,0),(879,0),(880,0),(881,0),(882,0),(883,0),(884,0),(885,0),(886,0),(887,0),(888,0),(889,0),(890,0),(891,0),(892,0),(893,0),(894,0),(895,0),(896,0),(897,0),(898,0),(899,0),(900,0),(901,0),(902,0),(903,0),(904,0),(905,0),(906,0),(907,0),(908,0),(909,0),(910,0),(911,0),(912,0),(913,0),(914,0),(915,0),(916,0),(917,0),(918,0),(919,0),(920,0),(921,0),(922,0),(923,0),(924,0),(925,0),(926,0),(927,0),(928,0),(929,0),(930,0),(931,0),(932,0),(933,0),(934,0),(935,0),(936,0),(937,0),(938,0),(939,0),(940,0),(941,0),(942,0),(943,0),(944,0),(945,0),(946,0),(947,0),(948,0),(949,0),(950,0),(951,0),(952,0),(953,0),(954,0),(955,0),(956,0),(957,0),(958,0),(959,0),(960,0),(961,0),(962,0),(963,0),(964,0),(965,0),(966,0),(967,0),(968,0),(969,0),(970,0),(971,0),(972,0),(973,0),(974,0),(975,0),(976,0),(977,0),(978,0),(979,0),(980,0),(981,0),(982,0),(983,0),(984,0),(985,0),(986,0),(987,0),(988,0),(989,0),(990,0),(991,0),(992,0),(993,0),(994,0),(995,0),(996,0),(997,0),(998,0),(999,0),(1000,0);
/*!40000 ALTER TABLE `ml2_gre_allocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml2_gre_endpoints`
--

DROP TABLE IF EXISTS `ml2_gre_endpoints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml2_gre_endpoints` (
  `ip_address` varchar(64) NOT NULL,
  `host` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ip_address`),
  UNIQUE KEY `unique_ml2_gre_endpoints0host` (`host`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml2_gre_endpoints`
--

LOCK TABLES `ml2_gre_endpoints` WRITE;
/*!40000 ALTER TABLE `ml2_gre_endpoints` DISABLE KEYS */;
/*!40000 ALTER TABLE `ml2_gre_endpoints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml2_nexus_vxlan_allocations`
--

DROP TABLE IF EXISTS `ml2_nexus_vxlan_allocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml2_nexus_vxlan_allocations` (
  `vxlan_vni` int(11) NOT NULL,
  `allocated` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`vxlan_vni`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`allocated` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml2_nexus_vxlan_allocations`
--

LOCK TABLES `ml2_nexus_vxlan_allocations` WRITE;
/*!40000 ALTER TABLE `ml2_nexus_vxlan_allocations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ml2_nexus_vxlan_allocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml2_nexus_vxlan_mcast_groups`
--

DROP TABLE IF EXISTS `ml2_nexus_vxlan_mcast_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml2_nexus_vxlan_mcast_groups` (
  `id` varchar(36) NOT NULL,
  `mcast_group` varchar(64) NOT NULL,
  `associated_vni` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `associated_vni` (`associated_vni`),
  CONSTRAINT `ml2_nexus_vxlan_mcast_groups_ibfk_1` FOREIGN KEY (`associated_vni`) REFERENCES `ml2_nexus_vxlan_allocations` (`vxlan_vni`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml2_nexus_vxlan_mcast_groups`
--

LOCK TABLES `ml2_nexus_vxlan_mcast_groups` WRITE;
/*!40000 ALTER TABLE `ml2_nexus_vxlan_mcast_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `ml2_nexus_vxlan_mcast_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml2_port_binding_levels`
--

DROP TABLE IF EXISTS `ml2_port_binding_levels`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml2_port_binding_levels` (
  `port_id` varchar(36) NOT NULL,
  `host` varchar(255) NOT NULL,
  `level` int(11) NOT NULL,
  `driver` varchar(64) DEFAULT NULL,
  `segment_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`port_id`,`host`,`level`),
  KEY `ml2_port_binding_levels_ibfk_2` (`segment_id`),
  CONSTRAINT `ml2_port_binding_levels_ibfk_1` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ml2_port_binding_levels_ibfk_2` FOREIGN KEY (`segment_id`) REFERENCES `networksegments` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml2_port_binding_levels`
--

LOCK TABLES `ml2_port_binding_levels` WRITE;
/*!40000 ALTER TABLE `ml2_port_binding_levels` DISABLE KEYS */;
INSERT INTO `ml2_port_binding_levels` VALUES ('4fc10d04-40d2-4f22-8376-d5bfa0819d6a','aojea-devstack-leap15',0,'openvswitch','734ec93f-07c9-44df-b978-8c530166f7c3'),('b96a0937-dd5e-4128-9724-894049ccc75e','aojea-devstack-leap15',0,'openvswitch','af6a0df6-af97-44ce-8dce-f9ee8090db9d'),('dcaba317-892b-4153-87ff-c1cf6aa263dc','aojea-devstack-leap15',0,'openvswitch','af6a0df6-af97-44ce-8dce-f9ee8090db9d'),('ddf6870b-c46d-44a3-acf4-945d913e93db','aojea-devstack-leap15',0,'openvswitch','af6a0df6-af97-44ce-8dce-f9ee8090db9d');
/*!40000 ALTER TABLE `ml2_port_binding_levels` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml2_port_bindings`
--

DROP TABLE IF EXISTS `ml2_port_bindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml2_port_bindings` (
  `port_id` varchar(36) NOT NULL,
  `host` varchar(255) NOT NULL DEFAULT '',
  `vif_type` varchar(64) NOT NULL,
  `vnic_type` varchar(64) NOT NULL DEFAULT 'normal',
  `profile` varchar(4095) NOT NULL DEFAULT '',
  `vif_details` varchar(4095) NOT NULL DEFAULT '',
  `status` varchar(16) NOT NULL DEFAULT 'ACTIVE',
  PRIMARY KEY (`port_id`,`host`),
  CONSTRAINT `ml2_port_bindings_ibfk_1` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml2_port_bindings`
--

LOCK TABLES `ml2_port_bindings` WRITE;
/*!40000 ALTER TABLE `ml2_port_bindings` DISABLE KEYS */;
INSERT INTO `ml2_port_bindings` VALUES ('4fc10d04-40d2-4f22-8376-d5bfa0819d6a','aojea-devstack-leap15','ovs','normal','','{\"port_filter\": true, \"datapath_type\": \"system\", \"ovs_hybrid_plug\": false}','ACTIVE'),('b96a0937-dd5e-4128-9724-894049ccc75e','aojea-devstack-leap15','ovs','normal','','{\"port_filter\": true, \"datapath_type\": \"system\", \"ovs_hybrid_plug\": false}','ACTIVE'),('dcaba317-892b-4153-87ff-c1cf6aa263dc','aojea-devstack-leap15','ovs','normal','','{\"port_filter\": true, \"datapath_type\": \"system\", \"ovs_hybrid_plug\": false}','ACTIVE'),('ddf6870b-c46d-44a3-acf4-945d913e93db','aojea-devstack-leap15','ovs','normal','','{\"port_filter\": true, \"datapath_type\": \"system\", \"ovs_hybrid_plug\": false}','ACTIVE');
/*!40000 ALTER TABLE `ml2_port_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml2_ucsm_port_profiles`
--

DROP TABLE IF EXISTS `ml2_ucsm_port_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml2_ucsm_port_profiles` (
  `vlan_id` int(11) NOT NULL AUTO_INCREMENT,
  `profile_id` varchar(64) NOT NULL,
  `created_on_ucs` tinyint(1) NOT NULL,
  PRIMARY KEY (`vlan_id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`created_on_ucs` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml2_ucsm_port_profiles`
--

LOCK TABLES `ml2_ucsm_port_profiles` WRITE;
/*!40000 ALTER TABLE `ml2_ucsm_port_profiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `ml2_ucsm_port_profiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml2_vlan_allocations`
--

DROP TABLE IF EXISTS `ml2_vlan_allocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml2_vlan_allocations` (
  `physical_network` varchar(64) NOT NULL,
  `vlan_id` int(11) NOT NULL,
  `allocated` tinyint(1) NOT NULL,
  PRIMARY KEY (`physical_network`,`vlan_id`),
  KEY `ix_ml2_vlan_allocations_physical_network_allocated` (`physical_network`,`allocated`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`allocated` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml2_vlan_allocations`
--

LOCK TABLES `ml2_vlan_allocations` WRITE;
/*!40000 ALTER TABLE `ml2_vlan_allocations` DISABLE KEYS */;
/*!40000 ALTER TABLE `ml2_vlan_allocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml2_vxlan_allocations`
--

DROP TABLE IF EXISTS `ml2_vxlan_allocations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml2_vxlan_allocations` (
  `vxlan_vni` int(11) NOT NULL,
  `allocated` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`vxlan_vni`),
  KEY `ix_ml2_vxlan_allocations_allocated` (`allocated`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`allocated` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml2_vxlan_allocations`
--

LOCK TABLES `ml2_vxlan_allocations` WRITE;
/*!40000 ALTER TABLE `ml2_vxlan_allocations` DISABLE KEYS */;
INSERT INTO `ml2_vxlan_allocations` VALUES (1,0),(2,0),(3,0),(4,0),(5,0),(6,0),(7,0),(8,0),(9,0),(10,0),(11,0),(12,0),(13,0),(14,0),(15,0),(16,0),(17,0),(18,0),(19,0),(20,0),(21,0),(22,0),(23,0),(24,0),(25,0),(26,0),(27,0),(28,0),(29,0),(30,0),(31,0),(32,0),(33,0),(34,0),(35,0),(36,0),(37,0),(38,0),(39,0),(40,0),(41,0),(42,0),(43,0),(44,0),(45,0),(46,0),(47,0),(48,0),(49,0),(50,0),(51,0),(52,0),(53,0),(54,0),(55,0),(56,0),(57,0),(58,0),(59,0),(60,0),(61,0),(62,0),(63,0),(64,0),(65,0),(66,0),(67,0),(68,0),(69,0),(70,0),(71,0),(72,0),(73,0),(74,0),(75,0),(76,0),(77,0),(78,0),(79,0),(80,0),(81,0),(82,0),(83,0),(84,0),(85,0),(86,0),(87,0),(88,0),(89,0),(90,0),(91,0),(92,0),(93,0),(94,0),(95,0),(97,0),(98,0),(99,0),(100,0),(101,0),(102,0),(103,0),(104,0),(105,0),(106,0),(107,0),(108,0),(109,0),(110,0),(111,0),(112,0),(113,0),(114,0),(115,0),(116,0),(117,0),(118,0),(119,0),(120,0),(121,0),(122,0),(123,0),(124,0),(125,0),(126,0),(127,0),(128,0),(129,0),(130,0),(131,0),(132,0),(133,0),(134,0),(135,0),(136,0),(137,0),(138,0),(139,0),(140,0),(141,0),(142,0),(143,0),(144,0),(145,0),(146,0),(147,0),(148,0),(149,0),(150,0),(151,0),(152,0),(153,0),(154,0),(155,0),(156,0),(157,0),(158,0),(159,0),(160,0),(161,0),(162,0),(163,0),(164,0),(165,0),(166,0),(167,0),(168,0),(169,0),(170,0),(171,0),(172,0),(173,0),(174,0),(175,0),(176,0),(177,0),(178,0),(179,0),(180,0),(181,0),(182,0),(183,0),(184,0),(185,0),(186,0),(187,0),(188,0),(189,0),(190,0),(191,0),(192,0),(193,0),(194,0),(195,0),(196,0),(197,0),(198,0),(199,0),(200,0),(201,0),(202,0),(203,0),(204,0),(205,0),(206,0),(207,0),(208,0),(209,0),(210,0),(211,0),(212,0),(213,0),(214,0),(215,0),(216,0),(217,0),(218,0),(219,0),(220,0),(221,0),(222,0),(223,0),(224,0),(225,0),(226,0),(227,0),(228,0),(229,0),(230,0),(231,0),(232,0),(233,0),(234,0),(235,0),(236,0),(237,0),(238,0),(239,0),(240,0),(241,0),(242,0),(243,0),(244,0),(245,0),(246,0),(247,0),(248,0),(249,0),(250,0),(251,0),(252,0),(253,0),(254,0),(255,0),(256,0),(257,0),(258,0),(259,0),(260,0),(261,0),(262,0),(263,0),(264,0),(265,0),(266,0),(267,0),(268,0),(269,0),(270,0),(271,0),(272,0),(273,0),(274,0),(275,0),(276,0),(277,0),(278,0),(279,0),(280,0),(281,0),(282,0),(283,0),(284,0),(285,0),(286,0),(287,0),(288,0),(289,0),(290,0),(291,0),(292,0),(293,0),(294,0),(295,0),(296,0),(297,0),(298,0),(299,0),(300,0),(301,0),(302,0),(303,0),(304,0),(305,0),(306,0),(307,0),(308,0),(309,0),(310,0),(311,0),(312,0),(313,0),(314,0),(315,0),(316,0),(317,0),(318,0),(319,0),(320,0),(321,0),(322,0),(323,0),(324,0),(325,0),(326,0),(327,0),(328,0),(329,0),(330,0),(331,0),(332,0),(333,0),(334,0),(335,0),(336,0),(337,0),(338,0),(339,0),(340,0),(341,0),(342,0),(343,0),(344,0),(345,0),(346,0),(347,0),(348,0),(349,0),(350,0),(351,0),(352,0),(353,0),(354,0),(355,0),(356,0),(357,0),(358,0),(359,0),(360,0),(361,0),(362,0),(363,0),(364,0),(365,0),(366,0),(367,0),(368,0),(369,0),(370,0),(371,0),(372,0),(373,0),(374,0),(375,0),(376,0),(377,0),(378,0),(379,0),(380,0),(381,0),(382,0),(383,0),(384,0),(385,0),(386,0),(387,0),(388,0),(389,0),(390,0),(391,0),(392,0),(393,0),(394,0),(395,0),(396,0),(397,0),(398,0),(399,0),(400,0),(401,0),(402,0),(403,0),(404,0),(405,0),(406,0),(407,0),(408,0),(409,0),(410,0),(411,0),(412,0),(413,0),(414,0),(415,0),(416,0),(417,0),(418,0),(419,0),(420,0),(421,0),(422,0),(423,0),(424,0),(425,0),(426,0),(427,0),(428,0),(429,0),(430,0),(431,0),(432,0),(433,0),(434,0),(435,0),(436,0),(437,0),(438,0),(439,0),(440,0),(441,0),(442,0),(443,0),(444,0),(445,0),(446,0),(447,0),(448,0),(449,0),(450,0),(451,0),(452,0),(453,0),(454,0),(455,0),(456,0),(457,0),(458,0),(459,0),(460,0),(461,0),(462,0),(463,0),(464,0),(465,0),(466,0),(467,0),(468,0),(469,0),(470,0),(471,0),(472,0),(473,0),(474,0),(475,0),(476,0),(477,0),(478,0),(479,0),(480,0),(481,0),(482,0),(483,0),(484,0),(485,0),(486,0),(487,0),(488,0),(489,0),(490,0),(491,0),(492,0),(493,0),(494,0),(495,0),(496,0),(497,0),(498,0),(499,0),(500,0),(501,0),(502,0),(503,0),(504,0),(505,0),(506,0),(507,0),(508,0),(509,0),(510,0),(511,0),(512,0),(513,0),(514,0),(515,0),(516,0),(517,0),(518,0),(519,0),(520,0),(521,0),(522,0),(523,0),(524,0),(525,0),(526,0),(527,0),(528,0),(529,0),(530,0),(531,0),(532,0),(533,0),(534,0),(535,0),(536,0),(537,0),(538,0),(539,0),(540,0),(541,0),(542,0),(543,0),(544,0),(545,0),(546,0),(547,0),(548,0),(549,0),(550,0),(551,0),(552,0),(553,0),(554,0),(555,0),(556,0),(557,0),(558,0),(559,0),(560,0),(561,0),(562,0),(563,0),(564,0),(565,0),(566,0),(567,0),(568,0),(569,0),(570,0),(571,0),(572,0),(573,0),(574,0),(575,0),(576,0),(577,0),(578,0),(579,0),(580,0),(581,0),(582,0),(583,0),(584,0),(585,0),(586,0),(587,0),(588,0),(589,0),(590,0),(591,0),(592,0),(593,0),(594,0),(595,0),(596,0),(597,0),(598,0),(599,0),(600,0),(601,0),(602,0),(603,0),(604,0),(605,0),(606,0),(607,0),(608,0),(609,0),(610,0),(611,0),(612,0),(613,0),(614,0),(615,0),(616,0),(617,0),(618,0),(619,0),(620,0),(621,0),(622,0),(623,0),(624,0),(625,0),(626,0),(627,0),(628,0),(629,0),(630,0),(631,0),(632,0),(633,0),(634,0),(635,0),(636,0),(637,0),(638,0),(639,0),(640,0),(641,0),(642,0),(643,0),(644,0),(645,0),(646,0),(647,0),(648,0),(649,0),(650,0),(651,0),(652,0),(653,0),(654,0),(655,0),(656,0),(657,0),(658,0),(659,0),(660,0),(661,0),(662,0),(663,0),(664,0),(665,0),(666,0),(667,0),(668,0),(669,0),(670,0),(671,0),(672,0),(673,0),(674,0),(675,0),(676,0),(677,0),(678,0),(679,0),(680,0),(681,0),(682,0),(683,0),(684,0),(685,0),(686,0),(687,0),(688,0),(689,0),(690,0),(691,0),(692,0),(693,0),(694,0),(695,0),(696,0),(697,0),(698,0),(699,0),(700,0),(701,0),(702,0),(703,0),(704,0),(705,0),(706,0),(707,0),(708,0),(709,0),(710,0),(711,0),(712,0),(713,0),(714,0),(715,0),(716,0),(717,0),(718,0),(719,0),(720,0),(721,0),(722,0),(723,0),(724,0),(725,0),(726,0),(727,0),(728,0),(729,0),(730,0),(731,0),(732,0),(733,0),(734,0),(735,0),(736,0),(737,0),(738,0),(739,0),(740,0),(741,0),(742,0),(743,0),(744,0),(745,0),(746,0),(747,0),(748,0),(749,0),(750,0),(751,0),(752,0),(753,0),(754,0),(755,0),(756,0),(757,0),(758,0),(759,0),(760,0),(761,0),(762,0),(763,0),(764,0),(765,0),(766,0),(767,0),(768,0),(769,0),(770,0),(771,0),(772,0),(773,0),(774,0),(775,0),(776,0),(777,0),(778,0),(779,0),(780,0),(781,0),(782,0),(783,0),(784,0),(785,0),(786,0),(787,0),(788,0),(789,0),(790,0),(791,0),(792,0),(793,0),(794,0),(795,0),(796,0),(797,0),(798,0),(799,0),(800,0),(801,0),(802,0),(803,0),(804,0),(805,0),(806,0),(807,0),(808,0),(809,0),(810,0),(811,0),(812,0),(813,0),(814,0),(815,0),(816,0),(817,0),(818,0),(819,0),(820,0),(821,0),(822,0),(823,0),(824,0),(825,0),(826,0),(827,0),(828,0),(829,0),(830,0),(831,0),(832,0),(833,0),(834,0),(835,0),(836,0),(837,0),(838,0),(839,0),(840,0),(841,0),(842,0),(843,0),(844,0),(845,0),(846,0),(847,0),(848,0),(849,0),(850,0),(851,0),(852,0),(853,0),(854,0),(855,0),(856,0),(857,0),(858,0),(859,0),(860,0),(861,0),(862,0),(863,0),(864,0),(865,0),(866,0),(867,0),(868,0),(869,0),(870,0),(871,0),(872,0),(873,0),(874,0),(875,0),(876,0),(877,0),(878,0),(879,0),(880,0),(881,0),(882,0),(883,0),(884,0),(885,0),(886,0),(887,0),(888,0),(889,0),(890,0),(891,0),(892,0),(893,0),(894,0),(895,0),(896,0),(897,0),(898,0),(899,0),(900,0),(901,0),(902,0),(903,0),(904,0),(905,0),(906,0),(907,0),(908,0),(909,0),(910,0),(911,0),(912,0),(913,0),(914,0),(915,0),(916,0),(917,0),(918,0),(919,0),(920,0),(921,0),(922,0),(923,0),(924,0),(925,0),(926,0),(927,0),(928,0),(929,0),(930,0),(931,0),(932,0),(933,0),(934,0),(935,0),(936,0),(937,0),(938,0),(939,0),(940,0),(941,0),(942,0),(943,0),(944,0),(945,0),(946,0),(947,0),(948,0),(949,0),(950,0),(951,0),(952,0),(953,0),(954,0),(955,0),(956,0),(957,0),(958,0),(959,0),(960,0),(961,0),(962,0),(963,0),(964,0),(965,0),(966,0),(967,0),(968,0),(969,0),(970,0),(971,0),(972,0),(973,0),(974,0),(975,0),(976,0),(977,0),(978,0),(979,0),(980,0),(981,0),(982,0),(983,0),(984,0),(985,0),(986,0),(987,0),(988,0),(989,0),(990,0),(991,0),(992,0),(993,0),(994,0),(995,0),(996,0),(997,0),(998,0),(999,0),(1000,0),(96,1);
/*!40000 ALTER TABLE `ml2_vxlan_allocations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ml2_vxlan_endpoints`
--

DROP TABLE IF EXISTS `ml2_vxlan_endpoints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ml2_vxlan_endpoints` (
  `ip_address` varchar(64) NOT NULL,
  `udp_port` int(11) NOT NULL,
  `host` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ip_address`),
  UNIQUE KEY `unique_ml2_vxlan_endpoints0host` (`host`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ml2_vxlan_endpoints`
--

LOCK TABLES `ml2_vxlan_endpoints` WRITE;
/*!40000 ALTER TABLE `ml2_vxlan_endpoints` DISABLE KEYS */;
INSERT INTO `ml2_vxlan_endpoints` VALUES ('127.0.0.1',4789,'aojea-devstack-leap15');
/*!40000 ALTER TABLE `ml2_vxlan_endpoints` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `multi_provider_networks`
--

DROP TABLE IF EXISTS `multi_provider_networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `multi_provider_networks` (
  `network_id` varchar(36) NOT NULL,
  PRIMARY KEY (`network_id`),
  CONSTRAINT `multi_provider_networks_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `multi_provider_networks`
--

LOCK TABLES `multi_provider_networks` WRITE;
/*!40000 ALTER TABLE `multi_provider_networks` DISABLE KEYS */;
/*!40000 ALTER TABLE `multi_provider_networks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `networkconnections`
--

DROP TABLE IF EXISTS `networkconnections`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `networkconnections` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `network_gateway_id` varchar(36) DEFAULT NULL,
  `network_id` varchar(36) DEFAULT NULL,
  `segmentation_type` enum('flat','vlan') DEFAULT NULL,
  `segmentation_id` int(11) DEFAULT NULL,
  `port_id` varchar(36) NOT NULL,
  PRIMARY KEY (`port_id`),
  UNIQUE KEY `network_gateway_id` (`network_gateway_id`,`segmentation_type`,`segmentation_id`),
  KEY `network_id` (`network_id`),
  KEY `ix_networkconnections_tenant_id` (`tenant_id`),
  CONSTRAINT `networkconnections_ibfk_1` FOREIGN KEY (`network_gateway_id`) REFERENCES `networkgateways` (`id`) ON DELETE CASCADE,
  CONSTRAINT `networkconnections_ibfk_2` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `networkconnections_ibfk_3` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `networkconnections`
--

LOCK TABLES `networkconnections` WRITE;
/*!40000 ALTER TABLE `networkconnections` DISABLE KEYS */;
/*!40000 ALTER TABLE `networkconnections` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `networkdhcpagentbindings`
--

DROP TABLE IF EXISTS `networkdhcpagentbindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `networkdhcpagentbindings` (
  `network_id` varchar(36) NOT NULL,
  `dhcp_agent_id` varchar(36) NOT NULL,
  PRIMARY KEY (`network_id`,`dhcp_agent_id`),
  KEY `dhcp_agent_id` (`dhcp_agent_id`),
  CONSTRAINT `networkdhcpagentbindings_ibfk_1` FOREIGN KEY (`dhcp_agent_id`) REFERENCES `agents` (`id`) ON DELETE CASCADE,
  CONSTRAINT `networkdhcpagentbindings_ibfk_2` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `networkdhcpagentbindings`
--

LOCK TABLES `networkdhcpagentbindings` WRITE;
/*!40000 ALTER TABLE `networkdhcpagentbindings` DISABLE KEYS */;
INSERT INTO `networkdhcpagentbindings` VALUES ('e056503d-0d93-44a0-a9d5-d8540b347d8f','771e29d4-1b5c-4946-b7f6-b9dae0d1b158'),('f0718f76-f4a7-4549-b54b-5d1826daf9e4','771e29d4-1b5c-4946-b7f6-b9dae0d1b158');
/*!40000 ALTER TABLE `networkdhcpagentbindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `networkdnsdomains`
--

DROP TABLE IF EXISTS `networkdnsdomains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `networkdnsdomains` (
  `network_id` varchar(36) NOT NULL,
  `dns_domain` varchar(255) NOT NULL,
  PRIMARY KEY (`network_id`),
  KEY `ix_networkdnsdomains_network_id` (`network_id`),
  CONSTRAINT `networkdnsdomains_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `networkdnsdomains`
--

LOCK TABLES `networkdnsdomains` WRITE;
/*!40000 ALTER TABLE `networkdnsdomains` DISABLE KEYS */;
/*!40000 ALTER TABLE `networkdnsdomains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `networkgatewaydevicereferences`
--

DROP TABLE IF EXISTS `networkgatewaydevicereferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `networkgatewaydevicereferences` (
  `id` varchar(36) NOT NULL,
  `network_gateway_id` varchar(36) NOT NULL,
  `interface_name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`,`network_gateway_id`,`interface_name`),
  KEY `network_gateway_id` (`network_gateway_id`),
  CONSTRAINT `networkgatewaydevicereferences_ibfk_1` FOREIGN KEY (`network_gateway_id`) REFERENCES `networkgateways` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `networkgatewaydevicereferences`
--

LOCK TABLES `networkgatewaydevicereferences` WRITE;
/*!40000 ALTER TABLE `networkgatewaydevicereferences` DISABLE KEYS */;
/*!40000 ALTER TABLE `networkgatewaydevicereferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `networkgatewaydevices`
--

DROP TABLE IF EXISTS `networkgatewaydevices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `networkgatewaydevices` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `nsx_id` varchar(36) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `connector_type` varchar(10) DEFAULT NULL,
  `connector_ip` varchar(64) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_networkgatewaydevices_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `networkgatewaydevices`
--

LOCK TABLES `networkgatewaydevices` WRITE;
/*!40000 ALTER TABLE `networkgatewaydevices` DISABLE KEYS */;
/*!40000 ALTER TABLE `networkgatewaydevices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `networkgateways`
--

DROP TABLE IF EXISTS `networkgateways`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `networkgateways` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `tenant_id` varchar(36) DEFAULT NULL,
  `default` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`default` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `networkgateways`
--

LOCK TABLES `networkgateways` WRITE;
/*!40000 ALTER TABLE `networkgateways` DISABLE KEYS */;
/*!40000 ALTER TABLE `networkgateways` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `networkqueuemappings`
--

DROP TABLE IF EXISTS `networkqueuemappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `networkqueuemappings` (
  `network_id` varchar(36) NOT NULL,
  `queue_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`network_id`),
  KEY `queue_id` (`queue_id`),
  CONSTRAINT `networkqueuemappings_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `networkqueuemappings_ibfk_2` FOREIGN KEY (`queue_id`) REFERENCES `qosqueues` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `networkqueuemappings`
--

LOCK TABLES `networkqueuemappings` WRITE;
/*!40000 ALTER TABLE `networkqueuemappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `networkqueuemappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `networkrbacs`
--

DROP TABLE IF EXISTS `networkrbacs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `networkrbacs` (
  `id` varchar(36) NOT NULL,
  `object_id` varchar(36) NOT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `target_tenant` varchar(255) NOT NULL,
  `action` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_networkrbacs0tenant_target0object_id0action` (`action`,`object_id`,`target_tenant`),
  KEY `object_id` (`object_id`),
  KEY `ix_networkrbacs_project_id` (`project_id`),
  CONSTRAINT `networkrbacs_ibfk_1` FOREIGN KEY (`object_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `networkrbacs`
--

LOCK TABLES `networkrbacs` WRITE;
/*!40000 ALTER TABLE `networkrbacs` DISABLE KEYS */;
INSERT INTO `networkrbacs` VALUES ('23a5867c-6dbb-4471-a895-0c5ff6d21fad','f0718f76-f4a7-4549-b54b-5d1826daf9e4','7b41e5f1bc3149c9b1dd0c0eded62d11','*','access_as_external');
/*!40000 ALTER TABLE `networkrbacs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `networks`
--

DROP TABLE IF EXISTS `networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `networks` (
  `project_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `admin_state_up` tinyint(1) DEFAULT NULL,
  `vlan_transparent` tinyint(1) DEFAULT NULL,
  `standard_attr_id` bigint(20) NOT NULL,
  `availability_zone_hints` varchar(255) DEFAULT NULL,
  `mtu` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_networks0standard_attr_id` (`standard_attr_id`),
  KEY `ix_networks_project_id` (`project_id`),
  CONSTRAINT `networks_ibfk_1` FOREIGN KEY (`standard_attr_id`) REFERENCES `standardattributes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`admin_state_up` in (0,1)),
  CONSTRAINT `CONSTRAINT_3` CHECK (`vlan_transparent` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `networks`
--

LOCK TABLES `networks` WRITE;
/*!40000 ALTER TABLE `networks` DISABLE KEYS */;
INSERT INTO `networks` VALUES ('98d33a223ed04ad48871015367f41d19','e056503d-0d93-44a0-a9d5-d8540b347d8f','private','ACTIVE',1,NULL,8,'[]',1450),('7b41e5f1bc3149c9b1dd0c0eded62d11','f0718f76-f4a7-4549-b54b-5d1826daf9e4','public','ACTIVE',1,NULL,19,'[]',1500);
/*!40000 ALTER TABLE `networks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `networksecuritybindings`
--

DROP TABLE IF EXISTS `networksecuritybindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `networksecuritybindings` (
  `network_id` varchar(36) NOT NULL,
  `port_security_enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`network_id`),
  CONSTRAINT `networksecuritybindings_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`port_security_enabled` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `networksecuritybindings`
--

LOCK TABLES `networksecuritybindings` WRITE;
/*!40000 ALTER TABLE `networksecuritybindings` DISABLE KEYS */;
INSERT INTO `networksecuritybindings` VALUES ('e056503d-0d93-44a0-a9d5-d8540b347d8f',1),('f0718f76-f4a7-4549-b54b-5d1826daf9e4',1);
/*!40000 ALTER TABLE `networksecuritybindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `networksegments`
--

DROP TABLE IF EXISTS `networksegments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `networksegments` (
  `id` varchar(36) NOT NULL,
  `network_id` varchar(36) NOT NULL,
  `network_type` varchar(32) NOT NULL,
  `physical_network` varchar(64) DEFAULT NULL,
  `segmentation_id` int(11) DEFAULT NULL,
  `is_dynamic` tinyint(1) NOT NULL DEFAULT 0,
  `segment_index` int(11) NOT NULL DEFAULT 0,
  `standard_attr_id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_networksegments0standard_attr_id` (`standard_attr_id`),
  KEY `network_id` (`network_id`),
  CONSTRAINT `networksegments_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE,
  CONSTRAINT `networksegments_ibfk_2` FOREIGN KEY (`standard_attr_id`) REFERENCES `standardattributes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`is_dynamic` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `networksegments`
--

LOCK TABLES `networksegments` WRITE;
/*!40000 ALTER TABLE `networksegments` DISABLE KEYS */;
INSERT INTO `networksegments` VALUES ('734ec93f-07c9-44df-b978-8c530166f7c3','f0718f76-f4a7-4549-b54b-5d1826daf9e4','flat','public',NULL,0,0,20,NULL),('af6a0df6-af97-44ce-8dce-f9ee8090db9d','e056503d-0d93-44a0-a9d5-d8540b347d8f','vxlan',NULL,96,0,0,9,NULL);
/*!40000 ALTER TABLE `networksegments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `neutron_nsx_network_mappings`
--

DROP TABLE IF EXISTS `neutron_nsx_network_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `neutron_nsx_network_mappings` (
  `neutron_id` varchar(36) NOT NULL,
  `nsx_id` varchar(36) NOT NULL,
  PRIMARY KEY (`neutron_id`,`nsx_id`),
  CONSTRAINT `neutron_nsx_network_mappings_ibfk_1` FOREIGN KEY (`neutron_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `neutron_nsx_network_mappings`
--

LOCK TABLES `neutron_nsx_network_mappings` WRITE;
/*!40000 ALTER TABLE `neutron_nsx_network_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `neutron_nsx_network_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `neutron_nsx_port_mappings`
--

DROP TABLE IF EXISTS `neutron_nsx_port_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `neutron_nsx_port_mappings` (
  `neutron_id` varchar(36) NOT NULL,
  `nsx_port_id` varchar(36) NOT NULL,
  `nsx_switch_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`neutron_id`),
  CONSTRAINT `neutron_nsx_port_mappings_ibfk_1` FOREIGN KEY (`neutron_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `neutron_nsx_port_mappings`
--

LOCK TABLES `neutron_nsx_port_mappings` WRITE;
/*!40000 ALTER TABLE `neutron_nsx_port_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `neutron_nsx_port_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `neutron_nsx_router_mappings`
--

DROP TABLE IF EXISTS `neutron_nsx_router_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `neutron_nsx_router_mappings` (
  `neutron_id` varchar(36) NOT NULL,
  `nsx_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`neutron_id`),
  CONSTRAINT `neutron_nsx_router_mappings_ibfk_1` FOREIGN KEY (`neutron_id`) REFERENCES `routers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `neutron_nsx_router_mappings`
--

LOCK TABLES `neutron_nsx_router_mappings` WRITE;
/*!40000 ALTER TABLE `neutron_nsx_router_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `neutron_nsx_router_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `neutron_nsx_security_group_mappings`
--

DROP TABLE IF EXISTS `neutron_nsx_security_group_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `neutron_nsx_security_group_mappings` (
  `neutron_id` varchar(36) NOT NULL,
  `nsx_id` varchar(36) NOT NULL,
  PRIMARY KEY (`neutron_id`,`nsx_id`),
  CONSTRAINT `neutron_nsx_security_group_mappings_ibfk_1` FOREIGN KEY (`neutron_id`) REFERENCES `securitygroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `neutron_nsx_security_group_mappings`
--

LOCK TABLES `neutron_nsx_security_group_mappings` WRITE;
/*!40000 ALTER TABLE `neutron_nsx_security_group_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `neutron_nsx_security_group_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nexthops`
--

DROP TABLE IF EXISTS `nexthops`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nexthops` (
  `rule_id` int(11) NOT NULL,
  `nexthop` varchar(64) NOT NULL,
  PRIMARY KEY (`rule_id`,`nexthop`),
  CONSTRAINT `nexthops_ibfk_1` FOREIGN KEY (`rule_id`) REFERENCES `routerrules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nexthops`
--

LOCK TABLES `nexthops` WRITE;
/*!40000 ALTER TABLE `nexthops` DISABLE KEYS */;
/*!40000 ALTER TABLE `nexthops` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nsxv_edge_dhcp_static_bindings`
--

DROP TABLE IF EXISTS `nsxv_edge_dhcp_static_bindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nsxv_edge_dhcp_static_bindings` (
  `edge_id` varchar(36) NOT NULL,
  `mac_address` varchar(32) NOT NULL,
  `binding_id` varchar(36) NOT NULL,
  PRIMARY KEY (`edge_id`,`mac_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nsxv_edge_dhcp_static_bindings`
--

LOCK TABLES `nsxv_edge_dhcp_static_bindings` WRITE;
/*!40000 ALTER TABLE `nsxv_edge_dhcp_static_bindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `nsxv_edge_dhcp_static_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nsxv_edge_vnic_bindings`
--

DROP TABLE IF EXISTS `nsxv_edge_vnic_bindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nsxv_edge_vnic_bindings` (
  `edge_id` varchar(36) NOT NULL,
  `vnic_index` int(11) NOT NULL,
  `tunnel_index` int(11) NOT NULL,
  `network_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`edge_id`,`vnic_index`,`tunnel_index`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nsxv_edge_vnic_bindings`
--

LOCK TABLES `nsxv_edge_vnic_bindings` WRITE;
/*!40000 ALTER TABLE `nsxv_edge_vnic_bindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `nsxv_edge_vnic_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nsxv_firewall_rule_bindings`
--

DROP TABLE IF EXISTS `nsxv_firewall_rule_bindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nsxv_firewall_rule_bindings` (
  `rule_id` varchar(36) NOT NULL,
  `edge_id` varchar(36) NOT NULL,
  `rule_vse_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`rule_id`,`edge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nsxv_firewall_rule_bindings`
--

LOCK TABLES `nsxv_firewall_rule_bindings` WRITE;
/*!40000 ALTER TABLE `nsxv_firewall_rule_bindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `nsxv_firewall_rule_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nsxv_internal_edges`
--

DROP TABLE IF EXISTS `nsxv_internal_edges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nsxv_internal_edges` (
  `ext_ip_address` varchar(64) NOT NULL,
  `router_id` varchar(36) DEFAULT NULL,
  `purpose` enum('inter_edge_net') DEFAULT NULL,
  PRIMARY KEY (`ext_ip_address`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nsxv_internal_edges`
--

LOCK TABLES `nsxv_internal_edges` WRITE;
/*!40000 ALTER TABLE `nsxv_internal_edges` DISABLE KEYS */;
/*!40000 ALTER TABLE `nsxv_internal_edges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nsxv_internal_networks`
--

DROP TABLE IF EXISTS `nsxv_internal_networks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nsxv_internal_networks` (
  `network_purpose` enum('inter_edge_net') NOT NULL,
  `network_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`network_purpose`),
  KEY `network_id` (`network_id`),
  CONSTRAINT `nsxv_internal_networks_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nsxv_internal_networks`
--

LOCK TABLES `nsxv_internal_networks` WRITE;
/*!40000 ALTER TABLE `nsxv_internal_networks` DISABLE KEYS */;
/*!40000 ALTER TABLE `nsxv_internal_networks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nsxv_port_index_mappings`
--

DROP TABLE IF EXISTS `nsxv_port_index_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nsxv_port_index_mappings` (
  `port_id` varchar(36) NOT NULL,
  `device_id` varchar(255) NOT NULL,
  `index` int(11) NOT NULL,
  PRIMARY KEY (`port_id`),
  UNIQUE KEY `device_id` (`device_id`,`index`),
  CONSTRAINT `nsxv_port_index_mappings_ibfk_1` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nsxv_port_index_mappings`
--

LOCK TABLES `nsxv_port_index_mappings` WRITE;
/*!40000 ALTER TABLE `nsxv_port_index_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `nsxv_port_index_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nsxv_port_vnic_mappings`
--

DROP TABLE IF EXISTS `nsxv_port_vnic_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nsxv_port_vnic_mappings` (
  `neutron_id` varchar(36) NOT NULL,
  `nsx_id` varchar(42) NOT NULL,
  PRIMARY KEY (`neutron_id`,`nsx_id`),
  CONSTRAINT `nsxv_port_vnic_mappings_ibfk_1` FOREIGN KEY (`neutron_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nsxv_port_vnic_mappings`
--

LOCK TABLES `nsxv_port_vnic_mappings` WRITE;
/*!40000 ALTER TABLE `nsxv_port_vnic_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `nsxv_port_vnic_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nsxv_router_bindings`
--

DROP TABLE IF EXISTS `nsxv_router_bindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nsxv_router_bindings` (
  `status` varchar(16) NOT NULL,
  `status_description` varchar(255) DEFAULT NULL,
  `router_id` varchar(36) NOT NULL,
  `edge_id` varchar(36) DEFAULT NULL,
  `lswitch_id` varchar(36) DEFAULT NULL,
  `appliance_size` enum('compact','large','xlarge','quadlarge') DEFAULT NULL,
  `edge_type` enum('service','vdr') DEFAULT NULL,
  PRIMARY KEY (`router_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nsxv_router_bindings`
--

LOCK TABLES `nsxv_router_bindings` WRITE;
/*!40000 ALTER TABLE `nsxv_router_bindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `nsxv_router_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nsxv_router_ext_attributes`
--

DROP TABLE IF EXISTS `nsxv_router_ext_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nsxv_router_ext_attributes` (
  `router_id` varchar(36) NOT NULL,
  `distributed` tinyint(1) NOT NULL,
  `router_type` enum('shared','exclusive') NOT NULL,
  `service_router` tinyint(1) NOT NULL,
  PRIMARY KEY (`router_id`),
  CONSTRAINT `nsxv_router_ext_attributes_ibfk_1` FOREIGN KEY (`router_id`) REFERENCES `routers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`distributed` in (0,1)),
  CONSTRAINT `CONSTRAINT_2` CHECK (`service_router` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nsxv_router_ext_attributes`
--

LOCK TABLES `nsxv_router_ext_attributes` WRITE;
/*!40000 ALTER TABLE `nsxv_router_ext_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `nsxv_router_ext_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nsxv_rule_mappings`
--

DROP TABLE IF EXISTS `nsxv_rule_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nsxv_rule_mappings` (
  `neutron_id` varchar(36) NOT NULL,
  `nsx_rule_id` varchar(36) NOT NULL,
  PRIMARY KEY (`neutron_id`,`nsx_rule_id`),
  CONSTRAINT `nsxv_rule_mappings_ibfk_1` FOREIGN KEY (`neutron_id`) REFERENCES `securitygrouprules` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nsxv_rule_mappings`
--

LOCK TABLES `nsxv_rule_mappings` WRITE;
/*!40000 ALTER TABLE `nsxv_rule_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `nsxv_rule_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nsxv_security_group_section_mappings`
--

DROP TABLE IF EXISTS `nsxv_security_group_section_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nsxv_security_group_section_mappings` (
  `neutron_id` varchar(36) NOT NULL,
  `ip_section_id` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`neutron_id`),
  CONSTRAINT `nsxv_security_group_section_mappings_ibfk_1` FOREIGN KEY (`neutron_id`) REFERENCES `securitygroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nsxv_security_group_section_mappings`
--

LOCK TABLES `nsxv_security_group_section_mappings` WRITE;
/*!40000 ALTER TABLE `nsxv_security_group_section_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `nsxv_security_group_section_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nsxv_spoofguard_policy_network_mappings`
--

DROP TABLE IF EXISTS `nsxv_spoofguard_policy_network_mappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nsxv_spoofguard_policy_network_mappings` (
  `network_id` varchar(36) NOT NULL,
  `policy_id` varchar(36) NOT NULL,
  PRIMARY KEY (`network_id`),
  CONSTRAINT `nsxv_spoofguard_policy_network_mappings_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nsxv_spoofguard_policy_network_mappings`
--

LOCK TABLES `nsxv_spoofguard_policy_network_mappings` WRITE;
/*!40000 ALTER TABLE `nsxv_spoofguard_policy_network_mappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `nsxv_spoofguard_policy_network_mappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nsxv_tz_network_bindings`
--

DROP TABLE IF EXISTS `nsxv_tz_network_bindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nsxv_tz_network_bindings` (
  `network_id` varchar(36) NOT NULL,
  `binding_type` enum('flat','vlan','portgroup') NOT NULL,
  `phy_uuid` varchar(36) NOT NULL,
  `vlan_id` int(11) NOT NULL,
  PRIMARY KEY (`network_id`,`binding_type`,`phy_uuid`,`vlan_id`),
  CONSTRAINT `nsxv_tz_network_bindings_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nsxv_tz_network_bindings`
--

LOCK TABLES `nsxv_tz_network_bindings` WRITE;
/*!40000 ALTER TABLE `nsxv_tz_network_bindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `nsxv_tz_network_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nsxv_vdr_dhcp_bindings`
--

DROP TABLE IF EXISTS `nsxv_vdr_dhcp_bindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nsxv_vdr_dhcp_bindings` (
  `vdr_router_id` varchar(36) NOT NULL,
  `dhcp_router_id` varchar(36) NOT NULL,
  `dhcp_edge_id` varchar(36) NOT NULL,
  PRIMARY KEY (`vdr_router_id`),
  UNIQUE KEY `unique_nsxv_vdr_dhcp_bindings0dhcp_router_id` (`dhcp_router_id`),
  UNIQUE KEY `unique_nsxv_vdr_dhcp_bindings0dhcp_edge_id` (`dhcp_edge_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nsxv_vdr_dhcp_bindings`
--

LOCK TABLES `nsxv_vdr_dhcp_bindings` WRITE;
/*!40000 ALTER TABLE `nsxv_vdr_dhcp_bindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `nsxv_vdr_dhcp_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nuage_net_partition_router_mapping`
--

DROP TABLE IF EXISTS `nuage_net_partition_router_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nuage_net_partition_router_mapping` (
  `net_partition_id` varchar(36) NOT NULL,
  `router_id` varchar(36) NOT NULL,
  `nuage_router_id` varchar(36) DEFAULT NULL,
  `nuage_rtr_rd` varchar(36) DEFAULT NULL,
  `nuage_rtr_rt` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`net_partition_id`,`router_id`),
  UNIQUE KEY `nuage_router_id` (`nuage_router_id`),
  KEY `router_id` (`router_id`),
  CONSTRAINT `nuage_net_partition_router_mapping_ibfk_1` FOREIGN KEY (`net_partition_id`) REFERENCES `nuage_net_partitions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `nuage_net_partition_router_mapping_ibfk_2` FOREIGN KEY (`router_id`) REFERENCES `routers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nuage_net_partition_router_mapping`
--

LOCK TABLES `nuage_net_partition_router_mapping` WRITE;
/*!40000 ALTER TABLE `nuage_net_partition_router_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `nuage_net_partition_router_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nuage_net_partitions`
--

DROP TABLE IF EXISTS `nuage_net_partitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nuage_net_partitions` (
  `id` varchar(36) NOT NULL,
  `name` varchar(64) DEFAULT NULL,
  `l3dom_tmplt_id` varchar(36) DEFAULT NULL,
  `l2dom_tmplt_id` varchar(36) DEFAULT NULL,
  `isolated_zone` varchar(64) DEFAULT NULL,
  `shared_zone` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nuage_net_partitions`
--

LOCK TABLES `nuage_net_partitions` WRITE;
/*!40000 ALTER TABLE `nuage_net_partitions` DISABLE KEYS */;
/*!40000 ALTER TABLE `nuage_net_partitions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nuage_provider_net_bindings`
--

DROP TABLE IF EXISTS `nuage_provider_net_bindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nuage_provider_net_bindings` (
  `network_id` varchar(36) NOT NULL,
  `network_type` varchar(32) NOT NULL,
  `physical_network` varchar(64) NOT NULL,
  `vlan_id` int(11) NOT NULL,
  PRIMARY KEY (`network_id`),
  CONSTRAINT `nuage_provider_net_bindings_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nuage_provider_net_bindings`
--

LOCK TABLES `nuage_provider_net_bindings` WRITE;
/*!40000 ALTER TABLE `nuage_provider_net_bindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `nuage_provider_net_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nuage_subnet_l2dom_mapping`
--

DROP TABLE IF EXISTS `nuage_subnet_l2dom_mapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `nuage_subnet_l2dom_mapping` (
  `subnet_id` varchar(36) NOT NULL,
  `net_partition_id` varchar(36) DEFAULT NULL,
  `nuage_subnet_id` varchar(36) DEFAULT NULL,
  `nuage_l2dom_tmplt_id` varchar(36) DEFAULT NULL,
  `nuage_user_id` varchar(36) DEFAULT NULL,
  `nuage_group_id` varchar(36) DEFAULT NULL,
  `nuage_managed_subnet` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`subnet_id`),
  UNIQUE KEY `nuage_subnet_id` (`nuage_subnet_id`),
  KEY `net_partition_id` (`net_partition_id`),
  CONSTRAINT `nuage_subnet_l2dom_mapping_ibfk_1` FOREIGN KEY (`subnet_id`) REFERENCES `subnets` (`id`) ON DELETE CASCADE,
  CONSTRAINT `nuage_subnet_l2dom_mapping_ibfk_2` FOREIGN KEY (`net_partition_id`) REFERENCES `nuage_net_partitions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`nuage_managed_subnet` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nuage_subnet_l2dom_mapping`
--

LOCK TABLES `nuage_subnet_l2dom_mapping` WRITE;
/*!40000 ALTER TABLE `nuage_subnet_l2dom_mapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `nuage_subnet_l2dom_mapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poolloadbalanceragentbindings`
--

DROP TABLE IF EXISTS `poolloadbalanceragentbindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poolloadbalanceragentbindings` (
  `pool_id` varchar(36) NOT NULL,
  `agent_id` varchar(36) NOT NULL,
  PRIMARY KEY (`pool_id`),
  KEY `agent_id` (`agent_id`),
  CONSTRAINT `poolloadbalanceragentbindings_ibfk_1` FOREIGN KEY (`pool_id`) REFERENCES `pools` (`id`) ON DELETE CASCADE,
  CONSTRAINT `poolloadbalanceragentbindings_ibfk_2` FOREIGN KEY (`agent_id`) REFERENCES `agents` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poolloadbalanceragentbindings`
--

LOCK TABLES `poolloadbalanceragentbindings` WRITE;
/*!40000 ALTER TABLE `poolloadbalanceragentbindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `poolloadbalanceragentbindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poolmonitorassociations`
--

DROP TABLE IF EXISTS `poolmonitorassociations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poolmonitorassociations` (
  `status` varchar(16) NOT NULL,
  `status_description` varchar(255) DEFAULT NULL,
  `pool_id` varchar(36) NOT NULL,
  `monitor_id` varchar(36) NOT NULL,
  PRIMARY KEY (`pool_id`,`monitor_id`),
  KEY `monitor_id` (`monitor_id`),
  CONSTRAINT `poolmonitorassociations_ibfk_1` FOREIGN KEY (`pool_id`) REFERENCES `pools` (`id`),
  CONSTRAINT `poolmonitorassociations_ibfk_2` FOREIGN KEY (`monitor_id`) REFERENCES `healthmonitors` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poolmonitorassociations`
--

LOCK TABLES `poolmonitorassociations` WRITE;
/*!40000 ALTER TABLE `poolmonitorassociations` DISABLE KEYS */;
/*!40000 ALTER TABLE `poolmonitorassociations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pools`
--

DROP TABLE IF EXISTS `pools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pools` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `status` varchar(16) NOT NULL,
  `status_description` varchar(255) DEFAULT NULL,
  `vip_id` varchar(36) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `subnet_id` varchar(36) NOT NULL,
  `protocol` enum('HTTP','HTTPS','TCP') NOT NULL,
  `lb_method` enum('ROUND_ROBIN','LEAST_CONNECTIONS','SOURCE_IP') NOT NULL,
  `admin_state_up` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `vip_id` (`vip_id`),
  CONSTRAINT `pools_ibfk_1` FOREIGN KEY (`vip_id`) REFERENCES `vips` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`admin_state_up` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pools`
--

LOCK TABLES `pools` WRITE;
/*!40000 ALTER TABLE `pools` DISABLE KEYS */;
/*!40000 ALTER TABLE `pools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `poolstatisticss`
--

DROP TABLE IF EXISTS `poolstatisticss`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `poolstatisticss` (
  `pool_id` varchar(36) NOT NULL,
  `bytes_in` bigint(20) NOT NULL,
  `bytes_out` bigint(20) NOT NULL,
  `active_connections` bigint(20) NOT NULL,
  `total_connections` bigint(20) NOT NULL,
  PRIMARY KEY (`pool_id`),
  CONSTRAINT `poolstatisticss_ibfk_1` FOREIGN KEY (`pool_id`) REFERENCES `pools` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `poolstatisticss`
--

LOCK TABLES `poolstatisticss` WRITE;
/*!40000 ALTER TABLE `poolstatisticss` DISABLE KEYS */;
/*!40000 ALTER TABLE `poolstatisticss` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portbindingports`
--

DROP TABLE IF EXISTS `portbindingports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portbindingports` (
  `port_id` varchar(36) NOT NULL,
  `host` varchar(255) NOT NULL,
  PRIMARY KEY (`port_id`),
  CONSTRAINT `portbindingports_ibfk_1` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portbindingports`
--

LOCK TABLES `portbindingports` WRITE;
/*!40000 ALTER TABLE `portbindingports` DISABLE KEYS */;
/*!40000 ALTER TABLE `portbindingports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portdataplanestatuses`
--

DROP TABLE IF EXISTS `portdataplanestatuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portdataplanestatuses` (
  `port_id` varchar(36) NOT NULL,
  `data_plane_status` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`port_id`),
  KEY `ix_portdataplanestatuses_port_id` (`port_id`),
  CONSTRAINT `portdataplanestatuses_ibfk_1` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portdataplanestatuses`
--

LOCK TABLES `portdataplanestatuses` WRITE;
/*!40000 ALTER TABLE `portdataplanestatuses` DISABLE KEYS */;
/*!40000 ALTER TABLE `portdataplanestatuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portdnses`
--

DROP TABLE IF EXISTS `portdnses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portdnses` (
  `port_id` varchar(36) NOT NULL,
  `current_dns_name` varchar(255) NOT NULL,
  `current_dns_domain` varchar(255) NOT NULL,
  `previous_dns_name` varchar(255) NOT NULL,
  `previous_dns_domain` varchar(255) NOT NULL,
  `dns_name` varchar(255) NOT NULL,
  `dns_domain` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`port_id`),
  KEY `ix_portdnses_port_id` (`port_id`),
  CONSTRAINT `portdnses_ibfk_1` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portdnses`
--

LOCK TABLES `portdnses` WRITE;
/*!40000 ALTER TABLE `portdnses` DISABLE KEYS */;
/*!40000 ALTER TABLE `portdnses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portforwardings`
--

DROP TABLE IF EXISTS `portforwardings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portforwardings` (
  `id` varchar(36) NOT NULL,
  `floatingip_id` varchar(36) NOT NULL,
  `external_port` int(11) NOT NULL,
  `internal_neutron_port_id` varchar(36) NOT NULL,
  `protocol` varchar(40) NOT NULL,
  `socket` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_port_forwardings0floatingip_id0external_port` (`floatingip_id`,`external_port`),
  UNIQUE KEY `uniq_port_forwardings0internal_neutron_port_id0socket` (`internal_neutron_port_id`,`socket`),
  CONSTRAINT `portforwardings_ibfk_1` FOREIGN KEY (`floatingip_id`) REFERENCES `floatingips` (`id`) ON DELETE CASCADE,
  CONSTRAINT `portforwardings_ibfk_2` FOREIGN KEY (`internal_neutron_port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portforwardings`
--

LOCK TABLES `portforwardings` WRITE;
/*!40000 ALTER TABLE `portforwardings` DISABLE KEYS */;
/*!40000 ALTER TABLE `portforwardings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portqueuemappings`
--

DROP TABLE IF EXISTS `portqueuemappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portqueuemappings` (
  `port_id` varchar(36) NOT NULL,
  `queue_id` varchar(36) NOT NULL,
  PRIMARY KEY (`port_id`,`queue_id`),
  KEY `queue_id` (`queue_id`),
  CONSTRAINT `portqueuemappings_ibfk_1` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE,
  CONSTRAINT `portqueuemappings_ibfk_2` FOREIGN KEY (`queue_id`) REFERENCES `qosqueues` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portqueuemappings`
--

LOCK TABLES `portqueuemappings` WRITE;
/*!40000 ALTER TABLE `portqueuemappings` DISABLE KEYS */;
/*!40000 ALTER TABLE `portqueuemappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ports`
--

DROP TABLE IF EXISTS `ports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ports` (
  `project_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `network_id` varchar(36) NOT NULL,
  `mac_address` varchar(32) NOT NULL,
  `admin_state_up` tinyint(1) NOT NULL,
  `status` varchar(16) NOT NULL,
  `device_id` varchar(255) NOT NULL,
  `device_owner` varchar(255) NOT NULL,
  `standard_attr_id` bigint(20) NOT NULL,
  `ip_allocation` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_ports0network_id0mac_address` (`network_id`,`mac_address`),
  UNIQUE KEY `uniq_ports0standard_attr_id` (`standard_attr_id`),
  KEY `ix_ports_network_id_device_owner` (`network_id`,`device_owner`),
  KEY `ix_ports_network_id_mac_address` (`network_id`,`mac_address`),
  KEY `ix_ports_device_id` (`device_id`),
  KEY `ix_ports_project_id` (`project_id`),
  CONSTRAINT `ports_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`),
  CONSTRAINT `ports_ibfk_2` FOREIGN KEY (`standard_attr_id`) REFERENCES `standardattributes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`admin_state_up` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ports`
--

LOCK TABLES `ports` WRITE;
/*!40000 ALTER TABLE `ports` DISABLE KEYS */;
INSERT INTO `ports` VALUES ('','4fc10d04-40d2-4f22-8376-d5bfa0819d6a','','f0718f76-f4a7-4549-b54b-5d1826daf9e4','fa:16:3e:40:b6:97',1,'ACTIVE','f9507ef9-848a-4dc9-a23d-8675c1a5d134','network:router_gateway',28,'immediate'),('98d33a223ed04ad48871015367f41d19','b96a0937-dd5e-4128-9724-894049ccc75e','','e056503d-0d93-44a0-a9d5-d8540b347d8f','fa:16:3e:85:cf:08',1,'ACTIVE','f9507ef9-848a-4dc9-a23d-8675c1a5d134','network:router_interface',21,'immediate'),('98d33a223ed04ad48871015367f41d19','dcaba317-892b-4153-87ff-c1cf6aa263dc','','e056503d-0d93-44a0-a9d5-d8540b347d8f','fa:16:3e:58:08:ae',1,'ACTIVE','dhcpa0e59e50-e07f-5348-9b3e-e9b8a13de2e0-e056503d-0d93-44a0-a9d5-d8540b347d8f','network:dhcp',11,'immediate'),('98d33a223ed04ad48871015367f41d19','ddf6870b-c46d-44a3-acf4-945d913e93db','','e056503d-0d93-44a0-a9d5-d8540b347d8f','fa:16:3e:02:2c:ad',1,'ACTIVE','f9507ef9-848a-4dc9-a23d-8675c1a5d134','network:router_interface',29,'immediate');
/*!40000 ALTER TABLE `ports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `portsecuritybindings`
--

DROP TABLE IF EXISTS `portsecuritybindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `portsecuritybindings` (
  `port_id` varchar(36) NOT NULL,
  `port_security_enabled` tinyint(1) NOT NULL,
  PRIMARY KEY (`port_id`),
  CONSTRAINT `portsecuritybindings_ibfk_1` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`port_security_enabled` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `portsecuritybindings`
--

LOCK TABLES `portsecuritybindings` WRITE;
/*!40000 ALTER TABLE `portsecuritybindings` DISABLE KEYS */;
INSERT INTO `portsecuritybindings` VALUES ('4fc10d04-40d2-4f22-8376-d5bfa0819d6a',0),('b96a0937-dd5e-4128-9724-894049ccc75e',0),('dcaba317-892b-4153-87ff-c1cf6aa263dc',0),('ddf6870b-c46d-44a3-acf4-945d913e93db',0);
/*!40000 ALTER TABLE `portsecuritybindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `providerresourceassociations`
--

DROP TABLE IF EXISTS `providerresourceassociations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `providerresourceassociations` (
  `provider_name` varchar(255) NOT NULL,
  `resource_id` varchar(36) NOT NULL,
  PRIMARY KEY (`provider_name`,`resource_id`),
  UNIQUE KEY `resource_id` (`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `providerresourceassociations`
--

LOCK TABLES `providerresourceassociations` WRITE;
/*!40000 ALTER TABLE `providerresourceassociations` DISABLE KEYS */;
INSERT INTO `providerresourceassociations` VALUES ('single_node','f9507ef9-848a-4dc9-a23d-8675c1a5d134');
/*!40000 ALTER TABLE `providerresourceassociations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provisioningblocks`
--

DROP TABLE IF EXISTS `provisioningblocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provisioningblocks` (
  `standard_attr_id` bigint(20) NOT NULL,
  `entity` varchar(255) NOT NULL,
  PRIMARY KEY (`standard_attr_id`,`entity`),
  CONSTRAINT `provisioningblocks_ibfk_1` FOREIGN KEY (`standard_attr_id`) REFERENCES `standardattributes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provisioningblocks`
--

LOCK TABLES `provisioningblocks` WRITE;
/*!40000 ALTER TABLE `provisioningblocks` DISABLE KEYS */;
/*!40000 ALTER TABLE `provisioningblocks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qos_bandwidth_limit_rules`
--

DROP TABLE IF EXISTS `qos_bandwidth_limit_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qos_bandwidth_limit_rules` (
  `id` varchar(36) NOT NULL,
  `qos_policy_id` varchar(36) NOT NULL,
  `max_kbps` int(11) DEFAULT NULL,
  `max_burst_kbps` int(11) DEFAULT NULL,
  `direction` enum('egress','ingress') NOT NULL DEFAULT 'egress',
  PRIMARY KEY (`id`),
  UNIQUE KEY `qos_bandwidth_rules0qos_policy_id0direction` (`qos_policy_id`,`direction`),
  CONSTRAINT `qos_bandwidth_limit_rules_ibfk_1` FOREIGN KEY (`qos_policy_id`) REFERENCES `qos_policies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qos_bandwidth_limit_rules`
--

LOCK TABLES `qos_bandwidth_limit_rules` WRITE;
/*!40000 ALTER TABLE `qos_bandwidth_limit_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `qos_bandwidth_limit_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qos_dscp_marking_rules`
--

DROP TABLE IF EXISTS `qos_dscp_marking_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qos_dscp_marking_rules` (
  `id` varchar(36) NOT NULL,
  `qos_policy_id` varchar(36) NOT NULL,
  `dscp_mark` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `qos_policy_id` (`qos_policy_id`),
  CONSTRAINT `qos_dscp_marking_rules_ibfk_1` FOREIGN KEY (`qos_policy_id`) REFERENCES `qos_policies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qos_dscp_marking_rules`
--

LOCK TABLES `qos_dscp_marking_rules` WRITE;
/*!40000 ALTER TABLE `qos_dscp_marking_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `qos_dscp_marking_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qos_fip_policy_bindings`
--

DROP TABLE IF EXISTS `qos_fip_policy_bindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qos_fip_policy_bindings` (
  `policy_id` varchar(36) NOT NULL,
  `fip_id` varchar(36) NOT NULL,
  UNIQUE KEY `fip_id` (`fip_id`),
  KEY `policy_id` (`policy_id`),
  CONSTRAINT `qos_fip_policy_bindings_ibfk_1` FOREIGN KEY (`policy_id`) REFERENCES `qos_policies` (`id`) ON DELETE CASCADE,
  CONSTRAINT `qos_fip_policy_bindings_ibfk_2` FOREIGN KEY (`fip_id`) REFERENCES `floatingips` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qos_fip_policy_bindings`
--

LOCK TABLES `qos_fip_policy_bindings` WRITE;
/*!40000 ALTER TABLE `qos_fip_policy_bindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `qos_fip_policy_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qos_minimum_bandwidth_rules`
--

DROP TABLE IF EXISTS `qos_minimum_bandwidth_rules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qos_minimum_bandwidth_rules` (
  `id` varchar(36) NOT NULL,
  `qos_policy_id` varchar(36) NOT NULL,
  `min_kbps` int(11) DEFAULT NULL,
  `direction` enum('egress','ingress') NOT NULL DEFAULT 'egress',
  PRIMARY KEY (`id`),
  UNIQUE KEY `qos_minimum_bandwidth_rules0qos_policy_id0direction` (`qos_policy_id`,`direction`),
  KEY `ix_qos_minimum_bandwidth_rules_qos_policy_id` (`qos_policy_id`),
  CONSTRAINT `qos_minimum_bandwidth_rules_ibfk_1` FOREIGN KEY (`qos_policy_id`) REFERENCES `qos_policies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qos_minimum_bandwidth_rules`
--

LOCK TABLES `qos_minimum_bandwidth_rules` WRITE;
/*!40000 ALTER TABLE `qos_minimum_bandwidth_rules` DISABLE KEYS */;
/*!40000 ALTER TABLE `qos_minimum_bandwidth_rules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qos_network_policy_bindings`
--

DROP TABLE IF EXISTS `qos_network_policy_bindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qos_network_policy_bindings` (
  `policy_id` varchar(36) NOT NULL,
  `network_id` varchar(36) NOT NULL,
  UNIQUE KEY `network_id` (`network_id`),
  KEY `policy_id` (`policy_id`),
  CONSTRAINT `qos_network_policy_bindings_ibfk_1` FOREIGN KEY (`policy_id`) REFERENCES `qos_policies` (`id`) ON DELETE CASCADE,
  CONSTRAINT `qos_network_policy_bindings_ibfk_2` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qos_network_policy_bindings`
--

LOCK TABLES `qos_network_policy_bindings` WRITE;
/*!40000 ALTER TABLE `qos_network_policy_bindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `qos_network_policy_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qos_policies`
--

DROP TABLE IF EXISTS `qos_policies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qos_policies` (
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `standard_attr_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_qos_policies0standard_attr_id` (`standard_attr_id`),
  KEY `ix_qos_policies_project_id` (`project_id`),
  CONSTRAINT `qos_policies_ibfk_1` FOREIGN KEY (`standard_attr_id`) REFERENCES `standardattributes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qos_policies`
--

LOCK TABLES `qos_policies` WRITE;
/*!40000 ALTER TABLE `qos_policies` DISABLE KEYS */;
/*!40000 ALTER TABLE `qos_policies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qos_policies_default`
--

DROP TABLE IF EXISTS `qos_policies_default`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qos_policies_default` (
  `qos_policy_id` varchar(36) NOT NULL,
  `project_id` varchar(255) NOT NULL,
  PRIMARY KEY (`project_id`),
  KEY `qos_policy_id` (`qos_policy_id`),
  KEY `ix_qos_policies_default_project_id` (`project_id`),
  CONSTRAINT `qos_policies_default_ibfk_1` FOREIGN KEY (`qos_policy_id`) REFERENCES `qos_policies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qos_policies_default`
--

LOCK TABLES `qos_policies_default` WRITE;
/*!40000 ALTER TABLE `qos_policies_default` DISABLE KEYS */;
/*!40000 ALTER TABLE `qos_policies_default` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qos_port_policy_bindings`
--

DROP TABLE IF EXISTS `qos_port_policy_bindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qos_port_policy_bindings` (
  `policy_id` varchar(36) NOT NULL,
  `port_id` varchar(36) NOT NULL,
  UNIQUE KEY `port_id` (`port_id`),
  KEY `policy_id` (`policy_id`),
  CONSTRAINT `qos_port_policy_bindings_ibfk_1` FOREIGN KEY (`policy_id`) REFERENCES `qos_policies` (`id`) ON DELETE CASCADE,
  CONSTRAINT `qos_port_policy_bindings_ibfk_2` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qos_port_policy_bindings`
--

LOCK TABLES `qos_port_policy_bindings` WRITE;
/*!40000 ALTER TABLE `qos_port_policy_bindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `qos_port_policy_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qospolicyrbacs`
--

DROP TABLE IF EXISTS `qospolicyrbacs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qospolicyrbacs` (
  `id` varchar(36) NOT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `target_tenant` varchar(255) NOT NULL,
  `action` varchar(255) NOT NULL,
  `object_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `target_tenant` (`target_tenant`,`object_id`,`action`),
  KEY `object_id` (`object_id`),
  KEY `ix_qospolicyrbacs_project_id` (`project_id`),
  CONSTRAINT `qospolicyrbacs_ibfk_1` FOREIGN KEY (`object_id`) REFERENCES `qos_policies` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qospolicyrbacs`
--

LOCK TABLES `qospolicyrbacs` WRITE;
/*!40000 ALTER TABLE `qospolicyrbacs` DISABLE KEYS */;
/*!40000 ALTER TABLE `qospolicyrbacs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `qosqueues`
--

DROP TABLE IF EXISTS `qosqueues`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `qosqueues` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `default` tinyint(1) DEFAULT 0,
  `min` int(11) NOT NULL,
  `max` int(11) DEFAULT NULL,
  `qos_marking` enum('untrusted','trusted') DEFAULT NULL,
  `dscp` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_qosqueues_tenant_id` (`tenant_id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`default` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qosqueues`
--

LOCK TABLES `qosqueues` WRITE;
/*!40000 ALTER TABLE `qosqueues` DISABLE KEYS */;
/*!40000 ALTER TABLE `qosqueues` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quotas`
--

DROP TABLE IF EXISTS `quotas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quotas` (
  `id` varchar(36) NOT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `resource` varchar(255) DEFAULT NULL,
  `limit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ix_quotas_project_id` (`project_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotas`
--

LOCK TABLES `quotas` WRITE;
/*!40000 ALTER TABLE `quotas` DISABLE KEYS */;
/*!40000 ALTER TABLE `quotas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `quotausages`
--

DROP TABLE IF EXISTS `quotausages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `quotausages` (
  `project_id` varchar(255) NOT NULL,
  `resource` varchar(255) NOT NULL,
  `dirty` tinyint(1) NOT NULL DEFAULT 0,
  `in_use` int(11) NOT NULL DEFAULT 0,
  `reserved` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`project_id`,`resource`),
  KEY `ix_quotausages_resource` (`resource`),
  KEY `ix_quotausages_project_id` (`project_id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`dirty` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `quotausages`
--

LOCK TABLES `quotausages` WRITE;
/*!40000 ALTER TABLE `quotausages` DISABLE KEYS */;
INSERT INTO `quotausages` VALUES ('7b41e5f1bc3149c9b1dd0c0eded62d11','network',0,1,0),('7b41e5f1bc3149c9b1dd0c0eded62d11','security_group',0,1,0);
/*!40000 ALTER TABLE `quotausages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `reservations` (
  `id` varchar(36) NOT NULL,
  `project_id` varchar(255) DEFAULT NULL,
  `expiration` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `resourcedeltas`
--

DROP TABLE IF EXISTS `resourcedeltas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `resourcedeltas` (
  `resource` varchar(255) NOT NULL,
  `reservation_id` varchar(36) NOT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`resource`,`reservation_id`),
  KEY `reservation_id` (`reservation_id`),
  CONSTRAINT `resourcedeltas_ibfk_1` FOREIGN KEY (`reservation_id`) REFERENCES `reservations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `resourcedeltas`
--

LOCK TABLES `resourcedeltas` WRITE;
/*!40000 ALTER TABLE `resourcedeltas` DISABLE KEYS */;
/*!40000 ALTER TABLE `resourcedeltas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `router_extra_attributes`
--

DROP TABLE IF EXISTS `router_extra_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `router_extra_attributes` (
  `router_id` varchar(36) NOT NULL,
  `distributed` tinyint(1) NOT NULL DEFAULT 0,
  `service_router` tinyint(1) NOT NULL DEFAULT 0,
  `ha` tinyint(1) NOT NULL DEFAULT 0,
  `ha_vr_id` int(11) DEFAULT NULL,
  `availability_zone_hints` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`router_id`),
  CONSTRAINT `router_extra_attributes_ibfk_1` FOREIGN KEY (`router_id`) REFERENCES `routers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`distributed` in (0,1)),
  CONSTRAINT `CONSTRAINT_2` CHECK (`service_router` in (0,1)),
  CONSTRAINT `CONSTRAINT_3` CHECK (`ha` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `router_extra_attributes`
--

LOCK TABLES `router_extra_attributes` WRITE;
/*!40000 ALTER TABLE `router_extra_attributes` DISABLE KEYS */;
INSERT INTO `router_extra_attributes` VALUES ('f9507ef9-848a-4dc9-a23d-8675c1a5d134',0,0,0,0,'[]');
/*!40000 ALTER TABLE `router_extra_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `routerl3agentbindings`
--

DROP TABLE IF EXISTS `routerl3agentbindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `routerl3agentbindings` (
  `router_id` varchar(36) NOT NULL,
  `l3_agent_id` varchar(36) NOT NULL,
  `binding_index` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`router_id`,`l3_agent_id`),
  UNIQUE KEY `uniq_router_l3_agent_binding0router_id0binding_index0` (`router_id`,`binding_index`),
  KEY `l3_agent_id` (`l3_agent_id`),
  CONSTRAINT `routerl3agentbindings_ibfk_1` FOREIGN KEY (`l3_agent_id`) REFERENCES `agents` (`id`) ON DELETE CASCADE,
  CONSTRAINT `routerl3agentbindings_ibfk_2` FOREIGN KEY (`router_id`) REFERENCES `routers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `routerl3agentbindings`
--

LOCK TABLES `routerl3agentbindings` WRITE;
/*!40000 ALTER TABLE `routerl3agentbindings` DISABLE KEYS */;
INSERT INTO `routerl3agentbindings` VALUES ('f9507ef9-848a-4dc9-a23d-8675c1a5d134','ba2b379e-d9ea-4787-9a38-5331c1f8eaa5',1);
/*!40000 ALTER TABLE `routerl3agentbindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `routerports`
--

DROP TABLE IF EXISTS `routerports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `routerports` (
  `router_id` varchar(36) NOT NULL,
  `port_id` varchar(36) NOT NULL,
  `port_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`router_id`,`port_id`),
  UNIQUE KEY `uniq_routerports0port_id` (`port_id`),
  CONSTRAINT `routerports_ibfk_1` FOREIGN KEY (`router_id`) REFERENCES `routers` (`id`) ON DELETE CASCADE,
  CONSTRAINT `routerports_ibfk_2` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `routerports`
--

LOCK TABLES `routerports` WRITE;
/*!40000 ALTER TABLE `routerports` DISABLE KEYS */;
INSERT INTO `routerports` VALUES ('f9507ef9-848a-4dc9-a23d-8675c1a5d134','4fc10d04-40d2-4f22-8376-d5bfa0819d6a','network:router_gateway'),('f9507ef9-848a-4dc9-a23d-8675c1a5d134','b96a0937-dd5e-4128-9724-894049ccc75e','network:router_interface'),('f9507ef9-848a-4dc9-a23d-8675c1a5d134','ddf6870b-c46d-44a3-acf4-945d913e93db','network:router_interface');
/*!40000 ALTER TABLE `routerports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `routerroutes`
--

DROP TABLE IF EXISTS `routerroutes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `routerroutes` (
  `destination` varchar(64) NOT NULL,
  `nexthop` varchar(64) NOT NULL,
  `router_id` varchar(36) NOT NULL,
  PRIMARY KEY (`destination`,`nexthop`,`router_id`),
  KEY `router_id` (`router_id`),
  CONSTRAINT `routerroutes_ibfk_1` FOREIGN KEY (`router_id`) REFERENCES `routers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `routerroutes`
--

LOCK TABLES `routerroutes` WRITE;
/*!40000 ALTER TABLE `routerroutes` DISABLE KEYS */;
/*!40000 ALTER TABLE `routerroutes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `routerrules`
--

DROP TABLE IF EXISTS `routerrules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `routerrules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source` varchar(64) NOT NULL,
  `destination` varchar(64) NOT NULL,
  `action` varchar(10) NOT NULL,
  `router_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `router_id` (`router_id`),
  CONSTRAINT `routerrules_ibfk_1` FOREIGN KEY (`router_id`) REFERENCES `routers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `routerrules`
--

LOCK TABLES `routerrules` WRITE;
/*!40000 ALTER TABLE `routerrules` DISABLE KEYS */;
/*!40000 ALTER TABLE `routerrules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `routers`
--

DROP TABLE IF EXISTS `routers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `routers` (
  `project_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` varchar(16) DEFAULT NULL,
  `admin_state_up` tinyint(1) DEFAULT NULL,
  `gw_port_id` varchar(36) DEFAULT NULL,
  `enable_snat` tinyint(1) NOT NULL DEFAULT 1,
  `standard_attr_id` bigint(20) NOT NULL,
  `flavor_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_routers0standard_attr_id` (`standard_attr_id`),
  KEY `gw_port_id` (`gw_port_id`),
  KEY `flavor_id` (`flavor_id`),
  KEY `ix_routers_project_id` (`project_id`),
  CONSTRAINT `routers_ibfk_1` FOREIGN KEY (`gw_port_id`) REFERENCES `ports` (`id`),
  CONSTRAINT `routers_ibfk_2` FOREIGN KEY (`standard_attr_id`) REFERENCES `standardattributes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `routers_ibfk_3` FOREIGN KEY (`flavor_id`) REFERENCES `flavors` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`admin_state_up` in (0,1)),
  CONSTRAINT `CONSTRAINT_2` CHECK (`enable_snat` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `routers`
--

LOCK TABLES `routers` WRITE;
/*!40000 ALTER TABLE `routers` DISABLE KEYS */;
INSERT INTO `routers` VALUES ('98d33a223ed04ad48871015367f41d19','f9507ef9-848a-4dc9-a23d-8675c1a5d134','router1','ACTIVE',1,'4fc10d04-40d2-4f22-8376-d5bfa0819d6a',1,13,NULL);
/*!40000 ALTER TABLE `routers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `securitygroupportbindings`
--

DROP TABLE IF EXISTS `securitygroupportbindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `securitygroupportbindings` (
  `port_id` varchar(36) NOT NULL,
  `security_group_id` varchar(36) NOT NULL,
  PRIMARY KEY (`port_id`,`security_group_id`),
  KEY `security_group_id` (`security_group_id`),
  CONSTRAINT `securitygroupportbindings_ibfk_1` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE,
  CONSTRAINT `securitygroupportbindings_ibfk_2` FOREIGN KEY (`security_group_id`) REFERENCES `securitygroups` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `securitygroupportbindings`
--

LOCK TABLES `securitygroupportbindings` WRITE;
/*!40000 ALTER TABLE `securitygroupportbindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `securitygroupportbindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `securitygrouprules`
--

DROP TABLE IF EXISTS `securitygrouprules`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `securitygrouprules` (
  `project_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `security_group_id` varchar(36) NOT NULL,
  `remote_group_id` varchar(36) DEFAULT NULL,
  `direction` enum('ingress','egress') DEFAULT NULL,
  `ethertype` varchar(40) DEFAULT NULL,
  `protocol` varchar(40) DEFAULT NULL,
  `port_range_min` int(11) DEFAULT NULL,
  `port_range_max` int(11) DEFAULT NULL,
  `remote_ip_prefix` varchar(255) DEFAULT NULL,
  `standard_attr_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_securitygrouprules0standard_attr_id` (`standard_attr_id`),
  KEY `security_group_id` (`security_group_id`),
  KEY `remote_group_id` (`remote_group_id`),
  KEY `ix_securitygrouprules_project_id` (`project_id`),
  CONSTRAINT `securitygrouprules_ibfk_1` FOREIGN KEY (`security_group_id`) REFERENCES `securitygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `securitygrouprules_ibfk_2` FOREIGN KEY (`remote_group_id`) REFERENCES `securitygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `securitygrouprules_ibfk_3` FOREIGN KEY (`standard_attr_id`) REFERENCES `standardattributes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `securitygrouprules`
--

LOCK TABLES `securitygrouprules` WRITE;
/*!40000 ALTER TABLE `securitygrouprules` DISABLE KEYS */;
INSERT INTO `securitygrouprules` VALUES ('98d33a223ed04ad48871015367f41d19','24bafaa8-eb7b-4bf6-abbe-f75f7c9ea5b6','740a91e2-5a17-4eb3-a4d0-0de72651b2ed',NULL,'egress','IPv4',NULL,NULL,NULL,NULL,5),('98d33a223ed04ad48871015367f41d19','2a211218-a573-43cc-847b-d32abc256462','740a91e2-5a17-4eb3-a4d0-0de72651b2ed','740a91e2-5a17-4eb3-a4d0-0de72651b2ed','ingress','IPv6',NULL,NULL,NULL,NULL,6),('7b41e5f1bc3149c9b1dd0c0eded62d11','32728922-a06b-40c1-8397-9cb9a08a982e','7b6e9a39-4ea5-476c-8452-9124a5d6c5e7',NULL,'egress','IPv6',NULL,NULL,NULL,NULL,18),('98d33a223ed04ad48871015367f41d19','59cf9716-1988-4b88-a98f-e1cd67397348','740a91e2-5a17-4eb3-a4d0-0de72651b2ed',NULL,'egress','IPv6',NULL,NULL,NULL,NULL,7),('98d33a223ed04ad48871015367f41d19','6af3af9d-86a6-46d6-8081-acb18b3062e8','740a91e2-5a17-4eb3-a4d0-0de72651b2ed','740a91e2-5a17-4eb3-a4d0-0de72651b2ed','ingress','IPv4',NULL,NULL,NULL,NULL,4),('','7af4a35f-9935-4efc-9777-e06d150422b5','25681359-4a3d-45d9-8006-6d4e0046497e','25681359-4a3d-45d9-8006-6d4e0046497e','ingress','IPv6',NULL,NULL,NULL,NULL,26),('','92e2b6fd-06e6-4f03-8d12-b98277aabaf7','25681359-4a3d-45d9-8006-6d4e0046497e','25681359-4a3d-45d9-8006-6d4e0046497e','ingress','IPv4',NULL,NULL,NULL,NULL,24),('','9fba2a76-45e2-4ef3-ae8a-66c5ec2bb045','25681359-4a3d-45d9-8006-6d4e0046497e',NULL,'egress','IPv4',NULL,NULL,NULL,NULL,25),('7b41e5f1bc3149c9b1dd0c0eded62d11','bc7e6c23-8be9-4e68-aca1-37a2430c50bf','7b6e9a39-4ea5-476c-8452-9124a5d6c5e7','7b6e9a39-4ea5-476c-8452-9124a5d6c5e7','ingress','IPv6',NULL,NULL,NULL,NULL,17),('7b41e5f1bc3149c9b1dd0c0eded62d11','cf50841e-2821-4e84-88c9-ae29c3479c95','7b6e9a39-4ea5-476c-8452-9124a5d6c5e7','7b6e9a39-4ea5-476c-8452-9124a5d6c5e7','ingress','IPv4',NULL,NULL,NULL,NULL,15),('7b41e5f1bc3149c9b1dd0c0eded62d11','dc8356cd-59b6-4cad-a357-9d75c32b2c65','7b6e9a39-4ea5-476c-8452-9124a5d6c5e7',NULL,'egress','IPv4',NULL,NULL,NULL,NULL,16),('','dd94a2c3-359d-4928-a998-640618e9d21f','25681359-4a3d-45d9-8006-6d4e0046497e',NULL,'egress','IPv6',NULL,NULL,NULL,NULL,27);
/*!40000 ALTER TABLE `securitygrouprules` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `securitygroups`
--

DROP TABLE IF EXISTS `securitygroups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `securitygroups` (
  `project_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `standard_attr_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_securitygroups0standard_attr_id` (`standard_attr_id`),
  KEY `ix_securitygroups_project_id` (`project_id`),
  CONSTRAINT `securitygroups_ibfk_1` FOREIGN KEY (`standard_attr_id`) REFERENCES `standardattributes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `securitygroups`
--

LOCK TABLES `securitygroups` WRITE;
/*!40000 ALTER TABLE `securitygroups` DISABLE KEYS */;
INSERT INTO `securitygroups` VALUES ('','25681359-4a3d-45d9-8006-6d4e0046497e','default',23),('98d33a223ed04ad48871015367f41d19','740a91e2-5a17-4eb3-a4d0-0de72651b2ed','default',3),('7b41e5f1bc3149c9b1dd0c0eded62d11','7b6e9a39-4ea5-476c-8452-9124a5d6c5e7','default',14);
/*!40000 ALTER TABLE `securitygroups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `segmenthostmappings`
--

DROP TABLE IF EXISTS `segmenthostmappings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `segmenthostmappings` (
  `segment_id` varchar(36) NOT NULL,
  `host` varchar(255) NOT NULL,
  PRIMARY KEY (`segment_id`,`host`),
  KEY `ix_segmenthostmappings_segment_id` (`segment_id`),
  KEY `ix_segmenthostmappings_host` (`host`),
  CONSTRAINT `segmenthostmappings_ibfk_1` FOREIGN KEY (`segment_id`) REFERENCES `networksegments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `segmenthostmappings`
--

LOCK TABLES `segmenthostmappings` WRITE;
/*!40000 ALTER TABLE `segmenthostmappings` DISABLE KEYS */;
INSERT INTO `segmenthostmappings` VALUES ('734ec93f-07c9-44df-b978-8c530166f7c3','aojea-devstack-leap15');
/*!40000 ALTER TABLE `segmenthostmappings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `serviceprofiles`
--

DROP TABLE IF EXISTS `serviceprofiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `serviceprofiles` (
  `id` varchar(36) NOT NULL,
  `description` varchar(1024) DEFAULT NULL,
  `driver` varchar(1024) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT 1,
  `metainfo` varchar(4096) DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`enabled` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `serviceprofiles`
--

LOCK TABLES `serviceprofiles` WRITE;
/*!40000 ALTER TABLE `serviceprofiles` DISABLE KEYS */;
/*!40000 ALTER TABLE `serviceprofiles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessionpersistences`
--

DROP TABLE IF EXISTS `sessionpersistences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessionpersistences` (
  `vip_id` varchar(36) NOT NULL,
  `type` enum('SOURCE_IP','HTTP_COOKIE','APP_COOKIE') NOT NULL,
  `cookie_name` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`vip_id`),
  CONSTRAINT `sessionpersistences_ibfk_1` FOREIGN KEY (`vip_id`) REFERENCES `vips` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessionpersistences`
--

LOCK TABLES `sessionpersistences` WRITE;
/*!40000 ALTER TABLE `sessionpersistences` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessionpersistences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `standardattributes`
--

DROP TABLE IF EXISTS `standardattributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `standardattributes` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `resource_type` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `revision_number` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=461 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `standardattributes`
--

LOCK TABLES `standardattributes` WRITE;
/*!40000 ALTER TABLE `standardattributes` DISABLE KEYS */;
INSERT INTO `standardattributes` VALUES (1,'subnetpools','2018-09-05 14:40:46','2018-09-05 14:40:46','',0),(2,'subnetpools','2018-09-05 14:40:48','2018-09-05 14:40:48','',0),(3,'securitygroups','2018-09-05 14:40:52','2018-09-05 14:40:52','Default security group',1),(4,'securitygrouprules','2018-09-05 14:40:52','2018-09-05 14:40:52',NULL,0),(5,'securitygrouprules','2018-09-05 14:40:52','2018-09-05 14:40:52',NULL,0),(6,'securitygrouprules','2018-09-05 14:40:52','2018-09-05 14:40:52',NULL,0),(7,'securitygrouprules','2018-09-05 14:40:52','2018-09-05 14:40:52',NULL,0),(8,'networks','2018-09-05 14:40:52','2018-09-05 14:41:00','',3),(9,'networksegments','2018-09-05 14:40:52','2018-09-05 14:40:52',NULL,0),(10,'subnets','2018-09-05 14:40:55','2018-09-05 14:40:55','',0),(11,'ports','2018-09-05 14:40:57','2018-09-05 14:41:03','',5),(12,'subnets','2018-09-05 14:41:00','2018-09-05 14:41:00','',0),(13,'routers','2018-09-05 14:41:08','2018-09-05 14:41:44','',5),(14,'securitygroups','2018-09-05 14:41:13','2018-09-05 14:41:13','Default security group',1),(15,'securitygrouprules','2018-09-05 14:41:13','2018-09-05 14:41:13',NULL,0),(16,'securitygrouprules','2018-09-05 14:41:13','2018-09-05 14:41:13',NULL,0),(17,'securitygrouprules','2018-09-05 14:41:13','2018-09-05 14:41:13',NULL,0),(18,'securitygrouprules','2018-09-05 14:41:13','2018-09-05 14:41:13',NULL,0),(19,'networks','2018-09-05 14:41:13','2018-09-05 14:41:43','',3),(20,'networksegments','2018-09-05 14:41:13','2018-09-05 14:41:13',NULL,1),(21,'ports','2018-09-05 14:41:17','2018-09-05 14:41:25','',5),(22,'subnets','2018-09-05 14:41:22','2018-09-05 14:41:22','',0),(23,'securitygroups','2018-09-05 14:41:27','2018-09-05 14:41:27','Default security group',1),(24,'securitygrouprules','2018-09-05 14:41:27','2018-09-05 14:41:27',NULL,0),(25,'securitygrouprules','2018-09-05 14:41:27','2018-09-05 14:41:27',NULL,0),(26,'securitygrouprules','2018-09-05 14:41:27','2018-09-05 14:41:27',NULL,0),(27,'securitygrouprules','2018-09-05 14:41:27','2018-09-05 14:41:27',NULL,0),(28,'ports','2018-09-05 14:41:28','2018-09-05 14:41:45','',5),(29,'ports','2018-09-05 14:41:36','2018-09-05 14:41:45','',5),(30,'subnets','2018-09-05 14:41:43','2018-09-05 14:41:43','',0);
/*!40000 ALTER TABLE `standardattributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subnet_service_types`
--

DROP TABLE IF EXISTS `subnet_service_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subnet_service_types` (
  `subnet_id` varchar(36) NOT NULL,
  `service_type` varchar(255) NOT NULL,
  PRIMARY KEY (`subnet_id`,`service_type`),
  CONSTRAINT `subnet_service_types_ibfk_1` FOREIGN KEY (`subnet_id`) REFERENCES `subnets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subnet_service_types`
--

LOCK TABLES `subnet_service_types` WRITE;
/*!40000 ALTER TABLE `subnet_service_types` DISABLE KEYS */;
/*!40000 ALTER TABLE `subnet_service_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subnetpoolprefixes`
--

DROP TABLE IF EXISTS `subnetpoolprefixes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subnetpoolprefixes` (
  `cidr` varchar(64) NOT NULL,
  `subnetpool_id` varchar(36) NOT NULL,
  PRIMARY KEY (`cidr`,`subnetpool_id`),
  KEY `subnetpool_id` (`subnetpool_id`),
  CONSTRAINT `subnetpoolprefixes_ibfk_1` FOREIGN KEY (`subnetpool_id`) REFERENCES `subnetpools` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subnetpoolprefixes`
--

LOCK TABLES `subnetpoolprefixes` WRITE;
/*!40000 ALTER TABLE `subnetpoolprefixes` DISABLE KEYS */;
INSERT INTO `subnetpoolprefixes` VALUES ('10.0.0.0/22','f24611b7-35bc-49c5-b1ad-0a4393222ade'),('fd7d:4ac9:b806::/56','a27b2ed5-b07e-4471-8e09-6f8a62a8a0da');
/*!40000 ALTER TABLE `subnetpoolprefixes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subnetpools`
--

DROP TABLE IF EXISTS `subnetpools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subnetpools` (
  `project_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `ip_version` int(11) NOT NULL,
  `default_prefixlen` int(11) NOT NULL,
  `min_prefixlen` int(11) NOT NULL,
  `max_prefixlen` int(11) NOT NULL,
  `shared` tinyint(1) NOT NULL,
  `default_quota` int(11) DEFAULT NULL,
  `hash` varchar(36) NOT NULL DEFAULT '',
  `address_scope_id` varchar(36) DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `standard_attr_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_subnetpools0standard_attr_id` (`standard_attr_id`),
  KEY `ix_subnetpools_project_id` (`project_id`),
  CONSTRAINT `subnetpools_ibfk_1` FOREIGN KEY (`standard_attr_id`) REFERENCES `standardattributes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`shared` in (0,1)),
  CONSTRAINT `CONSTRAINT_2` CHECK (`is_default` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subnetpools`
--

LOCK TABLES `subnetpools` WRITE;
/*!40000 ALTER TABLE `subnetpools` DISABLE KEYS */;
INSERT INTO `subnetpools` VALUES ('7b41e5f1bc3149c9b1dd0c0eded62d11','a27b2ed5-b07e-4471-8e09-6f8a62a8a0da','shared-default-subnetpool-v6',6,64,64,128,1,NULL,'a9388daf-c151-4a95-b743-bdf96fe4bfd4',NULL,1,2),('7b41e5f1bc3149c9b1dd0c0eded62d11','f24611b7-35bc-49c5-b1ad-0a4393222ade','shared-default-subnetpool-v4',4,26,8,32,1,NULL,'146e63a1-8c35-47fb-aeb8-9522c6f81371',NULL,1,1);
/*!40000 ALTER TABLE `subnetpools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subnetroutes`
--

DROP TABLE IF EXISTS `subnetroutes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subnetroutes` (
  `destination` varchar(64) NOT NULL,
  `nexthop` varchar(64) NOT NULL,
  `subnet_id` varchar(36) NOT NULL,
  PRIMARY KEY (`destination`,`nexthop`,`subnet_id`),
  KEY `subnet_id` (`subnet_id`),
  CONSTRAINT `subnetroutes_ibfk_1` FOREIGN KEY (`subnet_id`) REFERENCES `subnets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subnetroutes`
--

LOCK TABLES `subnetroutes` WRITE;
/*!40000 ALTER TABLE `subnetroutes` DISABLE KEYS */;
/*!40000 ALTER TABLE `subnetroutes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subnets`
--

DROP TABLE IF EXISTS `subnets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subnets` (
  `project_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `network_id` varchar(36) DEFAULT NULL,
  `ip_version` int(11) NOT NULL,
  `cidr` varchar(64) NOT NULL,
  `gateway_ip` varchar(64) DEFAULT NULL,
  `enable_dhcp` tinyint(1) DEFAULT NULL,
  `ipv6_ra_mode` enum('slaac','dhcpv6-stateful','dhcpv6-stateless') DEFAULT NULL,
  `ipv6_address_mode` enum('slaac','dhcpv6-stateful','dhcpv6-stateless') DEFAULT NULL,
  `subnetpool_id` varchar(36) DEFAULT NULL,
  `standard_attr_id` bigint(20) NOT NULL,
  `segment_id` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uniq_subnets0standard_attr_id` (`standard_attr_id`),
  KEY `network_id` (`network_id`),
  KEY `ix_subnets_subnetpool_id` (`subnetpool_id`),
  KEY `segment_id` (`segment_id`),
  KEY `ix_subnets_project_id` (`project_id`),
  CONSTRAINT `subnets_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`),
  CONSTRAINT `subnets_ibfk_2` FOREIGN KEY (`standard_attr_id`) REFERENCES `standardattributes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `subnets_ibfk_3` FOREIGN KEY (`segment_id`) REFERENCES `networksegments` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`enable_dhcp` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subnets`
--

LOCK TABLES `subnets` WRITE;
/*!40000 ALTER TABLE `subnets` DISABLE KEYS */;
INSERT INTO `subnets` VALUES ('7b41e5f1bc3149c9b1dd0c0eded62d11','52aed585-feeb-4790-a9d4-7640dfe54d52','ipv6-public-subnet','f0718f76-f4a7-4549-b54b-5d1826daf9e4',6,'2001:db8::/64','2001:db8::2',0,NULL,NULL,NULL,30,NULL),('7b41e5f1bc3149c9b1dd0c0eded62d11','87e7c8c2-99a3-4617-a793-88d9dbf9207c','public-subnet','f0718f76-f4a7-4549-b54b-5d1826daf9e4',4,'172.24.4.0/24','172.24.4.1',0,NULL,NULL,NULL,22,NULL),('98d33a223ed04ad48871015367f41d19','a9e97f57-f9fc-49be-8980-105b7bcf02f1','private-subnet','e056503d-0d93-44a0-a9d5-d8540b347d8f',4,'10.0.0.0/26','10.0.0.1',1,NULL,NULL,'f24611b7-35bc-49c5-b1ad-0a4393222ade',10,NULL),('98d33a223ed04ad48871015367f41d19','c89a62ce-6d89-4f16-8787-f78d42d9a7b8','ipv6-private-subnet','e056503d-0d93-44a0-a9d5-d8540b347d8f',6,'fd7d:4ac9:b806::/64','fd7d:4ac9:b806::1',1,'slaac','slaac','a27b2ed5-b07e-4471-8e09-6f8a62a8a0da',12,NULL);
/*!40000 ALTER TABLE `subnets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `subports`
--

DROP TABLE IF EXISTS `subports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subports` (
  `port_id` varchar(36) NOT NULL,
  `trunk_id` varchar(36) NOT NULL,
  `segmentation_type` varchar(32) NOT NULL,
  `segmentation_id` int(11) NOT NULL,
  PRIMARY KEY (`port_id`),
  UNIQUE KEY `uniq_subport0trunk_id0segmentation_type0segmentation_id` (`trunk_id`,`segmentation_type`,`segmentation_id`),
  CONSTRAINT `subports_ibfk_1` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE,
  CONSTRAINT `subports_ibfk_2` FOREIGN KEY (`trunk_id`) REFERENCES `trunks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `subports`
--

LOCK TABLES `subports` WRITE;
/*!40000 ALTER TABLE `subports` DISABLE KEYS */;
/*!40000 ALTER TABLE `subports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tags`
--

DROP TABLE IF EXISTS `tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tags` (
  `standard_attr_id` bigint(20) NOT NULL,
  `tag` varchar(60) NOT NULL,
  PRIMARY KEY (`standard_attr_id`,`tag`),
  CONSTRAINT `tags_ibfk_1` FOREIGN KEY (`standard_attr_id`) REFERENCES `standardattributes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tags`
--

LOCK TABLES `tags` WRITE;
/*!40000 ALTER TABLE `tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trunks`
--

DROP TABLE IF EXISTS `trunks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trunks` (
  `admin_state_up` tinyint(1) NOT NULL DEFAULT 1,
  `project_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `port_id` varchar(36) NOT NULL,
  `status` varchar(16) NOT NULL DEFAULT 'ACTIVE',
  `standard_attr_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `port_id` (`port_id`),
  UNIQUE KEY `standard_attr_id` (`standard_attr_id`),
  KEY `ix_trunks_project_id` (`project_id`),
  CONSTRAINT `trunks_ibfk_1` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`) ON DELETE CASCADE,
  CONSTRAINT `trunks_ibfk_2` FOREIGN KEY (`standard_attr_id`) REFERENCES `standardattributes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `CONSTRAINT_1` CHECK (`admin_state_up` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trunks`
--

LOCK TABLES `trunks` WRITE;
/*!40000 ALTER TABLE `trunks` DISABLE KEYS */;
/*!40000 ALTER TABLE `trunks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tz_network_bindings`
--

DROP TABLE IF EXISTS `tz_network_bindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tz_network_bindings` (
  `network_id` varchar(36) NOT NULL,
  `binding_type` enum('flat','vlan','stt','gre','l3_ext') NOT NULL,
  `phy_uuid` varchar(36) NOT NULL,
  `vlan_id` int(11) NOT NULL,
  PRIMARY KEY (`network_id`,`binding_type`,`phy_uuid`,`vlan_id`),
  CONSTRAINT `tz_network_bindings_ibfk_1` FOREIGN KEY (`network_id`) REFERENCES `networks` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tz_network_bindings`
--

LOCK TABLES `tz_network_bindings` WRITE;
/*!40000 ALTER TABLE `tz_network_bindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `tz_network_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vcns_router_bindings`
--

DROP TABLE IF EXISTS `vcns_router_bindings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vcns_router_bindings` (
  `status` varchar(16) NOT NULL,
  `status_description` varchar(255) DEFAULT NULL,
  `router_id` varchar(36) NOT NULL,
  `edge_id` varchar(16) DEFAULT NULL,
  `lswitch_id` varchar(36) NOT NULL,
  PRIMARY KEY (`router_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vcns_router_bindings`
--

LOCK TABLES `vcns_router_bindings` WRITE;
/*!40000 ALTER TABLE `vcns_router_bindings` DISABLE KEYS */;
/*!40000 ALTER TABLE `vcns_router_bindings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vips`
--

DROP TABLE IF EXISTS `vips`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vips` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `status` varchar(16) NOT NULL,
  `status_description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `port_id` varchar(36) DEFAULT NULL,
  `protocol_port` int(11) NOT NULL,
  `protocol` enum('HTTP','HTTPS','TCP') NOT NULL,
  `pool_id` varchar(36) NOT NULL,
  `admin_state_up` tinyint(1) NOT NULL,
  `connection_limit` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pool_id` (`pool_id`),
  KEY `port_id` (`port_id`),
  CONSTRAINT `vips_ibfk_1` FOREIGN KEY (`port_id`) REFERENCES `ports` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`admin_state_up` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vips`
--

LOCK TABLES `vips` WRITE;
/*!40000 ALTER TABLE `vips` DISABLE KEYS */;
/*!40000 ALTER TABLE `vips` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vpnservices`
--

DROP TABLE IF EXISTS `vpnservices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `vpnservices` (
  `tenant_id` varchar(255) DEFAULT NULL,
  `id` varchar(36) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `status` varchar(16) NOT NULL,
  `admin_state_up` tinyint(1) NOT NULL,
  `subnet_id` varchar(36) NOT NULL,
  `router_id` varchar(36) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `subnet_id` (`subnet_id`),
  KEY `router_id` (`router_id`),
  CONSTRAINT `vpnservices_ibfk_1` FOREIGN KEY (`subnet_id`) REFERENCES `subnets` (`id`),
  CONSTRAINT `vpnservices_ibfk_2` FOREIGN KEY (`router_id`) REFERENCES `routers` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`admin_state_up` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vpnservices`
--

LOCK TABLES `vpnservices` WRITE;
/*!40000 ALTER TABLE `vpnservices` DISABLE KEYS */;
/*!40000 ALTER TABLE `vpnservices` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-09-07  7:24:18
