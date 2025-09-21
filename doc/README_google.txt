
  brew install --cask google-cloud-sdk
  gcloud init

  gcloud projects add-iam-policy-binding ish-notifier-472722 \
    --member="serviceAccount:ish-service-account@ish-notifier-472722.iam.gserviceaccount.com" \
    --role="projects/ish-notifier-472722/roles/ish_notifier_custom_role"