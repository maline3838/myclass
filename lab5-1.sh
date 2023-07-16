#!/bin/bash

pid=$$
echo "PID: ${pid}"

# 建立一個臨時目錄
tmp_dir=$(mktemp -d -t ci-$(date +%Y%m%d%H%M%S)-XXXXXXXXXX)
echo ${tmp_dir}

# 定義處理信號的函數
handle_exit() {
  echo "捕捉到退出信號，正在刪除臨時目錄..."
  rm -rf "$tmp_dir"
  exit
}

# 註冊 SIGINT 和 SIGTERM 信號的處理函數
trap handle_exit SIGINT SIGTERM

# 定義生成檔案的函數
generate_files() {
  local i=1
  while true; do
    echo $(date) > "${tmp_dir}/file${i}.txt"
    i=$((i+1))
    sleep 1
  done
}

# 開始生成檔案
generate_files