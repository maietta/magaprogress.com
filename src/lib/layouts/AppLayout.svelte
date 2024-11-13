<script lang="ts">
	import '../../app.postcss';
	// import SkipToContent from '$lib/components/content/skip-to-content.svelte';
	// import CompanyHeader from '$lib/components/structural/company-header.svelte';
	// import SiteHeader from '$lib/components/structural/site-header.svelte';
	// import SiteFooter from '$lib/components/structural/site-footer.svelte';
	// import CompanyFooter from '$lib/components/structural/company-footer.svelte';
	// import BackToTop from '$lib/components/content/back-to-top.svelte';
	let { children } = $props();
</script>

<div class="flex min-h-screen flex-col w-full">
	<header>
		<!-- <SkipToContent /> -->
		<div class="sticky top-0 z-10">
			<!-- <CompanyHeader /> -->
		</div>
	</header>
	<div class="sticky top-0 z-10">
		<!-- <SiteHeader /> -->
	</div>
	<div class="flex-grow">
		{@render children()}
	</div>

	<div class="footer-container">
		<!-- <SiteFooter /> -->
		<footer>
			<!-- <BackToTop /> -->
			<!-- <CompanyFooter /> -->
		</footer>
	</div>
</div>