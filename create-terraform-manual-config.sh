#!/usr/bin/env bash
#
# Copyright 2023, Seqera Labs
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#

# temporary workaround - this config should be created via terraform
source settings.sh

(kubectl delete configmap tower-terraform-cfg 2> /dev/null) || true
(kubectl delete secret tower-terraform-secrets 2> /dev/null) || true

kubectl create configmap tower-terraform-cfg \
    --from-literal=TOWER_DB_URL="jdbc:mysql://${TOWER_DB_HOSTNAME}:3306/${TOWER_DB_SCHEMA}?&usePipelineAuth=false&useBatchMultiSend=false" \
    --from-literal=TOWER_REDIS_URL="redis://${TOWER_REDIS_HOSTNAME}:6379"

kubectl create secret generic tower-terraform-secrets \
    --from-literal=TOWER_DB_PASSWORD="$TOWER_DB_PASSWORD"
