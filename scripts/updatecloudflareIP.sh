#!/bin/bash

OUTPUT_FILE="../cloudflareip.txt"  # 修改为相对路径，保存到仓库根目录

# 下载 Cloudflare 的 IPv4 和 IPv6 IP 段
IPv4_URL="https://www.cloudflare.com/ips-v4"
IPv6_URL="https://www.cloudflare.com/ips-v6"

# 清空输出文件，准备写入
> $OUTPUT_FILE


# 开始写入规则的开头部分
#echo "rules:" >> $OUTPUT_FILE
echo "payload:" >> $OUTPUT_FILE
# payload:
#   - '91.105.192.0/23'
#   - '2001:67c:4e8::/48'

# 处理 IPv4 IP 段


echo "Fetching and processing Cloudflare IPv4 IP ranges..."
curl -s "$IPv4_URL" | grep -oP '(\d+\.\d+\.\d+\.\d+/\d+)' | while IFS= read -r ip; do
    #echo " $ip" >> $OUTPUT_FILE
    #echo "  - IP-CIDR, $ip, cloudflareCDN" >> $OUTPUT_FILE
    echo "  - '$ip'" >> $OUTPUT_FILE
done

# 处理 IPv6 IP 段
echo "Fetching and processing Cloudflare IPv6 IP ranges..."
curl -s "$IPv6_URL" | grep -oP '([a-f0-9:]+/\d+)' | while IFS= read -r ip; do
    echo "  - '$ip'" >> $OUTPUT_FILE
done

# 输出完成信息
echo "Cloudflare IP ranges have been saved to $OUTPUT_FILE"
