<script setup lang="ts">
// You can either pass the full embedUrl OR just reportId + tenantId.
// Example using your exact iframe URL:
const embedUrl =
  "https://app.powerbi.com/reportEmbed?reportId=326a3278-6950-4062-8214-299d5bb629c9&autoAuth=true&ctid=dde2fb8f-d8e0-445e-b851-e69c198c1e59";

// If you prefer IDs instead, comment the line above and set:
// const reportId = '326a3278-6950-4062-8214-299d5bb629c9'
// const tenantId = 'dde2fb8f-d8e0-445e-b851-e69c198c1e59'
</script>

<template>
  <main class="min-h-screen bg-gray-50">
    <section class="p-6">
      <!-- Option A: Pass the full embedUrl -->
      <PowerBIReport
        :embed-url="embedUrl"
        title="proyectoBaseDatos"
        height="82vh"
      />

      <!-- Option B: Build the URL from IDs -->
      <!--
      <PowerBIReport
        title="proyectoBaseDatos"
        :report-id="reportId"
        :tenant-id="tenantId"
        :auto-auth="true"
        height="82vh"
      />
      -->
    </section>
  </main>
</template>

<style scoped>
/* Minimal spacing if you don’t use Tailwind */
main {
  font-family: ui-sans-serif, system-ui, -apple-system, Segoe UI, Roboto, Ubuntu,
    Cantarell, Noto Sans, Arial, "Apple Color Emoji", "Segoe UI Emoji";
}
</style>

<!-- Remember to register the component -->
<script lang="ts">
import PowerBIReport from "./components/PowerBIReport.vue";
export default { components: { PowerBIReport } };
</script>
