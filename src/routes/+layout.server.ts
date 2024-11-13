export const load = (async () => {

    let metatags = {
        title: "Hello, world!",
        description: "This is the description"
    };

    let user = { name: "John Doe" };

    return {
        metatags: metatags,
        user: user,
        session: null
    };
});