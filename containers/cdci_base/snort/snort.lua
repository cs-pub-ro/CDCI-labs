---------------------------------------------------------------------------
-- Snort 3 configuration for CDCI Lab (IDS)
-- Migrated from Snort 2.9.x snort.conf
-- (c) Mihai Chiroiu - CDCI
---------------------------------------------------------------------------

-- HOME_NET and EXTERNAL_NET
HOME_NET = 'any'
EXTERNAL_NET = 'any'

-- Network variables (servers)
DNS_SERVERS = HOME_NET
SMTP_SERVERS = HOME_NET
HTTP_SERVERS = HOME_NET
SQL_SERVERS = HOME_NET
TELNET_SERVERS = HOME_NET
SSH_SERVERS = HOME_NET
FTP_SERVERS = HOME_NET
SIP_SERVERS = HOME_NET

-- Port variables
HTTP_PORTS = ' 36 80 81 82 83 84 85 86 87 88 89 90 311 383 555 591 593 631 '
    .. '801 808 818 901 972 1158 1220 1414 1533 1741 1830 1942 2231 2301 '
    .. '2381 2578 2809 2980 3029 3037 3057 3128 3443 3702 4000 4343 4848 '
    .. '5000 5117 5250 5600 6080 6173 6988 7000 7001 7071 7144 7145 7510 '
    .. '7770 7777 7778 7779 8000 8008 8014 8028 8080 8081 8082 8085 8088 '
    .. '8090 8118 8123 8180 8181 8222 8243 8280 8300 8333 8344 8500 8509 '
    .. '8800 8888 8899 8983 9000 9060 9080 9090 9091 9111 9290 9443 9999 '
    .. '10000 11371 12601 13014 15489 29991 33300 34412 34443 34444 41080 '
    .. '44449 50000 50002 51423 53331 55252 55555 56712 '

SHELLCODE_PORTS = '!80'
ORACLE_PORTS = '1024:'
SSH_PORTS = '22'
FTP_PORTS = '21 2100 3535'
SIP_PORTS = '5060 5061 5600'
FILE_DATA_PORTS = HTTP_PORTS .. '110 143'

---------------------------------------------------------------------------
-- Configure DAQ (Data Acquisition)
---------------------------------------------------------------------------
daq =
{
    module_dirs =
    {
        '/usr/local/lib/daq/',
    },
}

---------------------------------------------------------------------------
-- Configure detection engine
---------------------------------------------------------------------------
search_engine = { search_method = 'ac_full' }

detection =
{
    pcre_match_limit = 3500,
    pcre_match_limit_recursion = 1500,
}

---------------------------------------------------------------------------
-- Configure logging / output
---------------------------------------------------------------------------
-- Alert to console (fast format) and log to file
alert_fast =
{
    file = true,
    packet = false,
}

-- Log directory
output =
{
    logdir = '/var/log/snort',
}

---------------------------------------------------------------------------
-- Configure normalization (replaces Snort 2 preprocessors)
---------------------------------------------------------------------------
normalizer =
{
    tcp = { },
    ip4 = { },
    ip6 = { },
}

---------------------------------------------------------------------------
-- Configure stream inspection (replaces stream5)
---------------------------------------------------------------------------
stream =
{
    ip_frags_only = false,
}

stream_tcp =
{
    policy = 'windows',
    session_timeout = 180,
    require_3whs = 180,
    overlap_limit = 10,
}

stream_udp =
{
    session_timeout = 180,
}

stream_icmp = { }

---------------------------------------------------------------------------
-- Configure service inspectors (replaces Snort 2 preprocessors)
---------------------------------------------------------------------------

-- HTTP inspector (replaces http_inspect preprocessor)
http_inspect = { }

-- FTP/Telnet (replaces ftp_telnet preprocessor)
ftp_server =
{
    def_max_param_len = 100,
}

telnet = { }

-- SMTP (replaces smtp preprocessor)
smtp =
{
    normalize_cmds = true,
}

-- SSH (replaces ssh preprocessor)
ssh = { }

-- DNS (replaces dns preprocessor)
dns = { }

-- SSL/TLS (replaces ssl preprocessor)
ssl = { }

-- SIP (replaces sip preprocessor)
sip = { }

-- IMAP
imap = { }

-- POP
pop = { }

-- DCE/RPC (replaces dcerpc2 preprocessor)
dce_smb = { }
dce_tcp = { }
dce_udp = { }

-- Modbus (SCADA)
modbus = { }

-- DNP3 (SCADA)
dnp3 = { }

---------------------------------------------------------------------------
-- Configure port scan detection
---------------------------------------------------------------------------
-- Uncomment to enable
-- port_scan = { memcap = 10000000, }

---------------------------------------------------------------------------
-- Configure classifications (migrated from classification.config)
---------------------------------------------------------------------------
classifications =
{
    { name = 'not-suspicious',                  priority = 3, text = 'Not Suspicious Traffic' },
    { name = 'unknown',                         priority = 3, text = 'Unknown Traffic' },
    { name = 'bad-unknown',                     priority = 2, text = 'Potentially Bad Traffic' },
    { name = 'attempted-recon',                 priority = 2, text = 'Attempted Information Leak' },
    { name = 'successful-recon-limited',        priority = 2, text = 'Information Leak' },
    { name = 'successful-recon-largescale',     priority = 2, text = 'Large Scale Information Leak' },
    { name = 'attempted-dos',                   priority = 2, text = 'Attempted Denial of Service' },
    { name = 'successful-dos',                  priority = 2, text = 'Denial of Service' },
    { name = 'attempted-user',                  priority = 1, text = 'Attempted User Privilege Gain' },
    { name = 'unsuccessful-user',               priority = 1, text = 'Unsuccessful User Privilege Gain' },
    { name = 'successful-user',                 priority = 1, text = 'Successful User Privilege Gain' },
    { name = 'attempted-admin',                 priority = 1, text = 'Attempted Administrator Privilege Gain' },
    { name = 'successful-admin',                priority = 1, text = 'Successful Administrator Privilege Gain' },
    { name = 'rpc-portmap-decode',              priority = 2, text = 'Decode of an RPC Query' },
    { name = 'shellcode-detect',                priority = 1, text = 'Executable Code was Detected' },
    { name = 'string-detect',                   priority = 3, text = 'A Suspicious String was Detected' },
    { name = 'suspicious-filename-detect',      priority = 2, text = 'A Suspicious Filename was Detected' },
    { name = 'suspicious-login',                priority = 2, text = 'An Attempted Login Using a Suspicious Username was Detected' },
    { name = 'system-call-detect',              priority = 2, text = 'A System Call was Detected' },
    { name = 'tcp-connection',                  priority = 4, text = 'A TCP Connection was Detected' },
    { name = 'trojan-activity',                 priority = 1, text = 'A Network Trojan was Detected' },
    { name = 'unusual-client-port-connection',  priority = 2, text = 'A Client was Using an Unusual Port' },
    { name = 'network-scan',                    priority = 3, text = 'Detection of a Network Scan' },
    { name = 'denial-of-service',               priority = 2, text = 'Detection of a Denial of Service Attack' },
    { name = 'non-standard-protocol',           priority = 2, text = 'Detection of a Non-Standard Protocol or Event' },
    { name = 'protocol-command-decode',         priority = 3, text = 'Generic Protocol Command Decode' },
    { name = 'web-application-activity',        priority = 2, text = 'Access to a Potentially Vulnerable Web Application' },
    { name = 'web-application-attack',          priority = 1, text = 'Web Application Attack' },
    { name = 'misc-activity',                   priority = 3, text = 'Misc activity' },
    { name = 'misc-attack',                     priority = 2, text = 'Misc Attack' },
    { name = 'icmp-event',                      priority = 3, text = 'Generic ICMP event' },
    { name = 'inappropriate-content',           priority = 1, text = 'Inappropriate Content was Detected' },
    { name = 'policy-violation',                priority = 1, text = 'Potential Corporate Privacy Violation' },
    { name = 'default-login-attempt',           priority = 2, text = 'Attempt to Login By a Default Username and Password' },
    { name = 'sdf',                             priority = 2, text = 'Sensitive Data was Transmitted Across the Network' },
    { name = 'file-format',                     priority = 1, text = 'Known malicious file or file based exploit' },
    { name = 'malware-cnc',                     priority = 1, text = 'Known malware command and control traffic' },
    { name = 'client-side-exploit',             priority = 1, text = 'Known client side exploit attempt' },
}

---------------------------------------------------------------------------
-- Configure references (migrated from reference.config)
---------------------------------------------------------------------------
references =
{
    { name = 'bugtraq',   url = 'http://www.securityfocus.com/bid/' },
    { name = 'cve',       url = 'http://cve.mitre.org/cgi-bin/cvename.cgi?name=' },
    { name = 'arachNIDS', url = 'http://www.whitehats.com/info/IDS' },
    { name = 'osvdb',     url = 'http://osvdb.org/show/osvdb/' },
    { name = 'McAfee',    url = 'http://vil.nai.com/vil/content/v_' },
    { name = 'nessus',    url = 'http://cgi.nessus.org/plugins/dump.php3?id=' },
    { name = 'url',       url = 'http://' },
    { name = 'msb',       url = 'http://technet.microsoft.com/en-us/security/bulletin/' },
}

---------------------------------------------------------------------------
-- Configure rules (IPS policy + local rules)
---------------------------------------------------------------------------
ips =
{
    -- Use the built-in connectivity-over-security policy as a base
    -- then overlay our custom lab rules
    enable_builtin_rules = true,

    variables =
    {
        nets =
        {
            HOME_NET = HOME_NET,
            EXTERNAL_NET = EXTERNAL_NET,
            DNS_SERVERS = DNS_SERVERS,
            SMTP_SERVERS = SMTP_SERVERS,
            HTTP_SERVERS = HTTP_SERVERS,
            SQL_SERVERS = SQL_SERVERS,
            TELNET_SERVERS = TELNET_SERVERS,
            SSH_SERVERS = SSH_SERVERS,
            FTP_SERVERS = FTP_SERVERS,
            SIP_SERVERS = SIP_SERVERS,
        },
        ports =
        {
            HTTP_PORTS = HTTP_PORTS,
            SHELLCODE_PORTS = SHELLCODE_PORTS,
            ORACLE_PORTS = ORACLE_PORTS,
            SSH_PORTS = SSH_PORTS,
            FTP_PORTS = FTP_PORTS,
            SIP_PORTS = SIP_PORTS,
            FILE_DATA_PORTS = FILE_DATA_PORTS,
        },
    },

    rules = [[
        include /etc/snort/rules/local.rules
    ]],
}
