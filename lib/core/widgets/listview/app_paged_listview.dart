import 'package:extra_pos/core/utils/app_paging_state.dart';
import 'package:flutter/material.dart';

class AppPaginationView extends StatefulWidget {

  AppPaginationView(
      {Key? key,
      this.currentPage: 0,
      this.pageSize = 25,
      this.totalRecordsCount = 0,
      this.listItemCount,
      required this.itemBuilder,
      this.gridDelegate =
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      this.shrinkWrap = false,
      this.reverse = false,
      this.scrollDirection = Axis.vertical,
      this.padding = const EdgeInsets.all(0),
      this.physics,
      this.scrollController,
      this.status,
      this.onScroll,
      this.onListReachedEnd,
      this.errorMessage,
      this.onListReady,
      this.onReadyToNextPage})
      : super(key: key);

  int currentPage;
  final int? pageSize;
  final int? totalRecordsCount;
  final int? listItemCount;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;
  final bool? reverse;
  final Axis? scrollDirection;
  final SliverGridDelegate? gridDelegate;
  final bool? shrinkWrap;
  final ScrollController? scrollController;
  final PagingStatus? status;
  final String? errorMessage;
  final Function(int start, int limit)? onListReady;
  final Function(double offset)? onScroll;
  final Function(
          int currentPage, int nextPage, int pageSize, int start, int limit)?
      onListReachedEnd;

  final Function(
          int currentPage, int nextPage, int pageSize, int start, int limit)?
      onReadyToNextPage;

  @override
  AppPaginationViewState createState() => AppPaginationViewState();

  final Widget Function(BuildContext, int) itemBuilder;
}

class AppPaginationViewState<T> extends State<AppPaginationView> {
  late ScrollController _scrollController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _getMainArea(),
        ),
        _getBottomArea()
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    _scrollController = widget.scrollController ?? ScrollController();

    if (widget.scrollController == null) {
      _scrollController.addListener(() {
        if (widget.onScroll != null) widget.onScroll!(_scrollController.offset);

        if (_scrollController.position.maxScrollExtent == _scrollController.offset) {
          if (widget.onListReachedEnd != null) {
            var start = widget.currentPage * widget.pageSize! + 1;
            var limit = widget.pageSize;

            widget.onListReachedEnd!(widget.currentPage, widget.currentPage + 1,
                widget.pageSize!, start, limit!);
          }

          if(widget.onReadyToNextPage != null) {
            var start = widget.currentPage * widget.pageSize! + 1;
            var limit = widget.pageSize;

            if (widget.status != PagingStatus.LOADING) {
              widget.onReadyToNextPage!(widget.currentPage,
                  widget.currentPage + 1, widget.pageSize!, start, limit!);
              // widget.currentPage = widget.currentPage + 1;
              // print(widget.currentPage);
            }
          }
        }
      });
    }

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      widget.onListReady!(widget.currentPage + 1, widget.pageSize!);
    });
  }

  _getMainArea() {
    if (widget.listItemCount! <= 0 && widget.status == PagingStatus.INITIAL) {
      return InitialLoader();
    }

    if (widget.listItemCount! <= 0 && widget.status == PagingStatus.LOADING) {
      return InitialLoader();
    }

    if (widget.listItemCount! <= 0 && widget.status == PagingStatus.ERROR) {
      return MessageArea(text: widget.errorMessage!);
    }

    if (widget.listItemCount! <= 0 && widget.status == PagingStatus.COMPLETED) {
      return MessageArea(text: 'No results found');
    }

    if (widget.listItemCount! > 0) {
      return _buildListView();
    }

    return Container();
  }

  _buildListView() {
    return Scrollbar(
      child: Container(
        margin: EdgeInsets.only(right: 6),
        child: ListView.builder(
          controller: _scrollController,
          reverse: widget.reverse!,
          shrinkWrap: widget.shrinkWrap!,
          scrollDirection: widget.scrollDirection!,
          physics: widget.physics,
          padding: widget.padding,
          itemCount: widget.listItemCount,
          itemBuilder: (context, index) {
            return widget.itemBuilder(context, index);
          },
        ),
      ),
    );
  }

  _getBottomArea() {
    if (widget.listItemCount! <= 0 && widget.status == PagingStatus.LOADING) {
      return Container();
    }

    if (widget.listItemCount! > 0 && widget.status == PagingStatus.LOADING) {
      return BottomLoader();
    }

    if (widget.listItemCount! > 0 && widget.status == PagingStatus.ERROR) {
      return MessageArea(text: 'Error while getting data...');
    }

    // widget.status == Status.LOADING ? BottomLoader() : Container()

    return Container();
  }
}

class BottomLoader extends StatelessWidget {
  const BottomLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Padding(
        padding: EdgeInsets.only(top: 16, bottom: 24),
        child: SizedBox(
          height: 16,
          width: 16,
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}

class InitialLoader extends StatelessWidget {
  const InitialLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(strokeWidth: 2));
  }
}

class MessageArea extends StatelessWidget {
  final String? text;

  const MessageArea({Key? key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text!),
    ));
  }
}
