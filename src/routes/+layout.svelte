<script lang="ts">
	import AppLayout from '$lib/layouts/AppLayout.svelte';
	import DashboardLayout from '$lib/layouts/DashboardLayout.svelte';

	import { ModeWatcher } from 'mode-watcher';
	import { setupViewTransition } from 'sveltekit-view-transition';
	setupViewTransition();

	import { page } from '$app/stores';

	let { children } = $props();
</script>

<svelte:head>
	<!-- <title>{metatags.title}</title>
	<meta name="description" content={metatags.description} /> -->
</svelte:head>

<ModeWatcher />
<div class="flex min-h-screen">
	{#if $page.data.session}
		<DashboardLayout>
			{@render children()}
		</DashboardLayout>
	{:else}
		<AppLayout>
			{@render children()}
		</AppLayout>
	{/if}
</div>