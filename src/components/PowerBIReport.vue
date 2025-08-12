<script setup lang="ts">
import { computed } from "vue";

/**
 * Reusable Power BI iframe wrapper.
 * - Pass either `embedUrl` directly, OR `reportId` + `tenantId` to construct the URL.
 * - `height` accepts any valid CSS length (e.g., "80vh", "600px").
 */
interface Props {
  embedUrl?: string;
  reportId?: string;
  tenantId?: string;
  title?: string;
  autoAuth?: boolean;
  height?: string;
  extraQuery?: Record<string, string | number | boolean>;
}

const props = withDefaults(defineProps<Props>(), {
  title: "Power BI Report",
  autoAuth: true,
  height: "80vh",
  extraQuery: () => ({}),
});

const embedSrc = computed(() => {
  if (props.embedUrl) return props.embedUrl;

  // Build from parts if no embedUrl is provided
  if (!props.reportId || !props.tenantId) return "";
  const base = new URL("https://app.powerbi.com/reportEmbed");
  base.searchParams.set("reportId", props.reportId);
  base.searchParams.set("ctid", props.tenantId);
  base.searchParams.set("autoAuth", String(props.autoAuth));

  Object.entries(props.extraQuery).forEach(([k, v]) => {
    base.searchParams.set(k, String(v));
  });

  return base.toString();
});
</script>

<template>
  <div class="w-full">
    <div class="w-full">
      <iframe
        v-if="embedSrc"
        :title="title"
        :src="embedSrc"
        :style="{ width: '100%', height }"
        frameborder="0"
        allowfullscreen="true"
        loading="lazy"
        class="rounded-xl shadow"
      ></iframe>

      <div v-else class="text-red-600">
        Missing <code>embedUrl</code> or (<code>reportId</code> +
        <code>tenantId</code>).
      </div>
    </div>
  </div>
</template>

<style scoped>
/* No custom styles required; class names are optional. */
</style>
