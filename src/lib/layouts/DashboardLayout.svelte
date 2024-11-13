<script lang="ts">
	interface Props {
		children?: import('svelte').Snippet;
	}

	let { children }: Props = $props();
	// import VerticalMenu from '$lib/components/VerticalMenu.svelte';
	// import { page } from '$app/stores';
	// let landing = $derived($page.url.pathname == '/' ? true : false);
</script>

<div class="flex flex-row w-full dashboard">
	<!-- Vertical Sidebar -->
	<!-- <div class=" bg-gray-800 text-white"> -->
	<!-- <VerticalMenu /> -->
	<!-- </div> -->
	<!-- Main Content Area -->
	<div class="flex-grow content flex flex-col">
		<div class="sticky top-0 z-10 bg-white p-4">
			<p>This is the dashboard layout</p>
		</div>
		<div class="flex-grow p-4">
			<!-- {#if landing}
				<p>You are on the landing</p>
			{:else}
				<p>You are not on the landing</p>

				{@render children()}
			{/if} -->
			{@render children?.()}
		</div>
		<div class="p-4 bg-gray-100">
			<p>This is the footer</p>
		</div>
	</div>
</div>