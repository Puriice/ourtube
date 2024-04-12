class User {
  final String username;
  final String profileImageUrl;
  final String subscribers;

  const User({
    required this.username,
    required this.profileImageUrl,
    required this.subscribers,
  });
}

const User currentUser = User(
  username: 'BBC',
  profileImageUrl:
      'https://yt3.googleusercontent.com/Y_iNjNBFP6bpHwT2hAHaLj7J3po22sGjwlR6mn26PWRp2IFesRAeNQEpSuh9xFiG8R57OOE83DE=s176-c-k-c0x00ffffff-no-rj',
  subscribers: '14.1M',
);

final List<User> sampleUser = [
  const User(
    username: 'BBC',
    profileImageUrl:
        'https://yt3.googleusercontent.com/Y_iNjNBFP6bpHwT2hAHaLj7J3po22sGjwlR6mn26PWRp2IFesRAeNQEpSuh9xFiG8R57OOE83DE=s176-c-k-c0x00ffffff-no-rj',
    subscribers: '14.1M',
  ),
  const User(
    username: 'ABC News',
    profileImageUrl:
        'https://yt3.googleusercontent.com/OOT0eq8LoW8V3PMURGYuk0kRSgRGP7EsuGZoODhHBcg1jCB1qkuIAxS-XGnjKX9Q6rf-WKTvkQ=s176-c-k-c0x00ffffff-no-rj',
    subscribers: '16.4M',
  ),
  const User(
    username: '(G)I-DLE (여자)아이들 (Official YouTube Channel)',
    profileImageUrl:
        'https://yt3.googleusercontent.com/ytc/AIdro_lBzSLbwovOh0sSKZLnm5baNZRDFKznD72-IrKh0XHYs-Y=s176-c-k-c0x00ffffff-no-rj',
    subscribers: '8.17M',
  ),
];
