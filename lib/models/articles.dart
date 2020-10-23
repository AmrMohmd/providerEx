import 'package:equatable/equatable.dart';
import "source.dart";

class Articles extends Equatable  {
	final Source source;
	final String author;
	final String title;
	final String description;
	final String url;
	final String urlToImage;
	final String publishedAt;
	final String content;

	Articles({this.source, this.author, this.title, this.description, this.url, this.urlToImage, this.publishedAt, this.content});

	factory Articles.fromJson(Map<String, dynamic> json) {
		return Articles(
			source: json['source'] != null ? new Source.fromJson(json['source']) : null,
			author: json['author'],
			title: json['title'],
			description: json['description'],
			url: json['url'],
			urlToImage: json['urlToImage'],
			publishedAt: json['publishedAt'],
			content: json['content'],
		);
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.source != null) {
      data['source'] = this.source.toJson();
    }
		data['author'] = this.author;
		data['title'] = this.title;
		data['description'] = this.description;
		data['url'] = this.url;
		data['urlToImage'] = this.urlToImage;
		data['publishedAt'] = this.publishedAt;
		data['content'] = this.content;
		return data;
	}

	@override
	List<Object> get props => [
		this.source,
		this.author,
		this.title,
		this.description,
		this.url,
		this.urlToImage,
		this.publishedAt,
		this.content
	];
}
