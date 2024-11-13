import type { Handle } from '@sveltejs/kit';
import * as auth from '$lib/server/auth.js';
import { sequence } from '@sveltejs/kit/hooks';

const handleAuth: Handle = async ({ event, resolve }) => {
	const sessionToken = event.cookies.get(auth.sessionCookieName);
	if (!sessionToken) {
		event.locals.user = null;
		event.locals.session = null;
		return resolve(event);
	}

	const { session, user } = await auth.validateSessionToken(sessionToken);
	if (session) {
		auth.setSessionTokenCookie(event, sessionToken, session.expiresAt);
	} else {
		auth.deleteSessionTokenCookie(event);
	}

	event.locals.user = user;
	event.locals.session = session;

	return resolve(event);
};

const healthcheck: Handle = async ({ event, resolve }) => {
	if (event.url.pathname === '/healthcheck') {
		return new Response('OK', {
			headers: {
				'Content-Type': 'text/plain'
			}
		});
	}

	return resolve(event);
};

export const handle = sequence(healthcheck,handleAuth);
